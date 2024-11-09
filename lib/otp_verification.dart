import 'dart:async';
import 'package:deals_dray/user_details.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller.dart';
import 'error_screen.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  int counter = 120;
  late Timer timer;
  String time = "";
  String number = "xxxxxxxxxx";
  String _pin = "";
  Controller controller = Controller();

  @override
  void initState() {
    super.initState();
    getNumber();
     startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return "$formattedMinutes:$formattedSeconds";
  }

  void startTimer() async{
    counter = 120;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter > 0) {
        counter--;
        setState(() {
          time = formatTime(counter);
        });
      } else {
        timer.cancel();
        print("Timer ended.");
      }
    });
  }

  Future<void> getNumber() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      number = prefs.getString("phone") ?? "xxxxxxxxxx";
    });
  }

  Future<void> sendOtp() async {
    try {
      await controller.sendOtp(_pin, context);
    } catch (e) {
      print("++++++++++++++++++++errorr*++++++++++++++++++");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(errorMessage: e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(right: 25, left: 15, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: 100,
                height: 100,
                child: Image.asset('assets/images/otp_phone.png'),
              ),
              const Text(
                "OTP Verification",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              const SizedBox(height: 20),
              Text(
                "We have sent you a unique OTP number to your mobile +91-$number",
                style: const TextStyle(fontSize: 18),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Pinput(
                  length: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Colors.red),
                    ),
                  ),
                    onCompleted: (pin) {
                      _pin = pin;
                    },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(time, style: const TextStyle(fontSize: 20)),
                    InkWell(
                      onTap: counter == 0 ? () => sendOtp() : null,
                      child: Text(
                        "SEND AGAIN",
                        style: TextStyle(fontSize: 20, color: counter == 0 ? Colors.red : Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendOtp();
        },
        child: const Icon(Icons.arrow_forward_outlined, color: Colors.white),
        backgroundColor: Colors.red,
      ),
    );
  }
}

