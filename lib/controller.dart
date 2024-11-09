import 'dart:convert';

import 'package:deals_dray/otp_verification.dart';
import 'package:deals_dray/user_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';


import 'dashboard.dart';
import 'error_screen.dart';
import 'login_page.dart';

class Controller {

  static const String splash_screen_api = 'http://devapiv4.dealsdray.com/api/v2/user/device/add';
  static const String login_details_api = "http://devapiv4.dealsdray.com/api/v2/user/otp";
  static const String otp_api = "http://devapiv4.dealsdray.com/api/v2/user/otp/verification";
  static const String registration_api = "http://devapiv4.dealsdray.com/api/v2/user/email/referral";


  Future<void> postData(context) async{
    try{
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      Response response = await post(
          Uri.parse(splash_screen_api),
          body:jsonEncode({
            "deviceType": "android",
            "deviceId": androidInfo.id,
            "deviceName": androidInfo.model,
            "deviceOSVersion": androidInfo.version.release,
            "deviceIPAddress": "11.433.445.66",
            "lat": "9.9312",
            "long": "76.2673",
            "buyer_gcmid": "",
            "buyer_pemid": "",
            "app": {
              "version": "1.20.5",
              "installTimeStamp": "2022-02-10T12:33:30.696Z",
              "uninstallTimeStamp": "2022-02-10T12:33:30.696Z",
              "downloadTimeStamp": "2022-02-10T12:33:30.696Z"
            }
          })
      );


      if (response.statusCode == 200) {
        var data =  jsonDecode(response.body.toString());
        var prefs = await SharedPreferences.getInstance();
        prefs.setString("deviceId", data['data']['deviceId']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  LoginPage()),
        );
      } else {
        // Failed POST request
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ErrorScreen(errorMessage: 'Failed with status code: ${response.statusCode}')),
        );
      }
    }
    catch(e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ErrorScreen(errorMessage: e.toString())),
      );
    }
  }


  Future<void> postLoginDetails(context, String number) async {
    try {

      var pref = await SharedPreferences.getInstance();
      pref.setString("phone", number);
      String? id = pref.getString("deviceId");
      Response response = await post(
          Uri.parse(login_details_api),
          body: jsonEncode({
            "mobileNumber": number,
            "deviceId": id,
          }),
          headers: {"Content-Type": "application/json"}
      );

      var data = jsonDecode(response.body.toString());
      if (data['status'] == 1) {
        pref.setString("userId", data['data']['userId']);
        Fluttertoast.showToast(

          msg: "OTP sent Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OtpVerification()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorScreen(errorMessage: data['data']['message']),
          ),
        );
      }
    } catch (e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(errorMessage: e.toString()),
        ),
      );
    }
  }


  Future<void> sendOtp(String otp,context) async {
    print("otp verifyong");

    var prefs=await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    String? deviceId = prefs.getString("deviceId");
    print("$userId  -- $deviceId");
    try{
      Response response = await post(
          Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp/verification'),
          body: jsonEncode({
            "otp": otp,
            "deviceId": deviceId,
            "userId": userId
          }),
          headers: {"Content-Type": "application/json"}
      );


      if (response.statusCode == 200) {

        var data =  jsonDecode(response.body.toString());
        if(data['status'] == 3) {
          Fluttertoast.showToast(
            msg: "Invalid OTP",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return;
        }
        else if(data['status'] == 1){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  UserDetails()),
          );
        }
        else{
          Fluttertoast.showToast(
            msg: "smthing went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }

      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ErrorScreen(errorMessage: 'Failed with status code: ${response.statusCode}')),
        );
      }
    }
    catch(e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ErrorScreen(errorMessage: e.toString())),
      );
    }
  }

  Future<void> registerUser(context, String email, String password, String ref_code) async{
    var prefs=await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    try{
      Response response = await post(
          Uri.parse(registration_api),
          body:jsonEncode({

            "email":email,
            "password":password,
            "referralCode":ref_code,
            "userId":userId
          }
          ),
          headers: {"Content-Type": "application/json"}

      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
      } else if (response.statusCode == 409) {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorScreen(errorMessage: 'Account already exists or conflicting data. Please try again.'),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorScreen(errorMessage: 'Failed with status code: ${response.statusCode}'),
          ),
        );
      }

    }
    catch(e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ErrorScreen(errorMessage: e.toString())),
      );
    }
  }

}