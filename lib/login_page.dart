import 'package:deals_dray/controller.dart';
import 'package:flutter/material.dart';
import 'package:deals_dray/custom/AnimatedToggle.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'error_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int toggleVal = 0;
  List<String> texts = ["phone number", "email address", "phone", "email"];
  final TextEditingController _controller = TextEditingController();
  bool isButtonEnabled = false;
  late Controller controller;
  @override
  Widget build(BuildContext context) {
    controller = Controller();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Align(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                AnimatedToggle(
                  values: ['Phone', 'Email'],
                  onToggleCallback: (value) {
                    if (_controller.text.length == 10)
                      setState(() {
                        isButtonEnabled = true;
                        toggleVal = value;
                      });
                    else
                      setState(() {
                        isButtonEnabled = false;
                        toggleVal = value;
                      });
                  },
                  buttonColor: Colors.red,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  width: 150,
                  height: 50,
                ),
                Container(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Glad to see you!",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
                      SizedBox(height: 10),
                      Text("please provide your ${texts[toggleVal]}")
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 250,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: texts[toggleVal + 2],
                        ),
                        cursorColor: Colors.red,
                        onChanged: (text) {
                          // Check the text length to enable/disable button
                          setState(() {
                            isButtonEnabled = text.length == 10;
                          });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 250,
                  height: 50,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: isButtonEnabled ? btnPress : null,
                    child: Text("SEND CODE"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

   void btnPress() async{
    String number = _controller.text;
    if(number.isNumericOnly) {
      controller.postLoginDetails(context,number);
    }
    else {
      print("Enter valid ");
      Fluttertoast.showToast(
          msg: "Enter valid number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }



}
