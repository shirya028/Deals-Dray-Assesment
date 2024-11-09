import 'package:flutter/material.dart';

import 'controller.dart';
class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  late Controller controller;
  late TextEditingController email,password,ref_code;

  @override
  Widget build(BuildContext context) {
    controller= Controller();
    email= TextEditingController();
    password= TextEditingController();
    ref_code= TextEditingController();

    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_outlined ,color: Colors.white),
        backgroundColor: Colors.red,
        onPressed: () {
            controller.registerUser(context, email.text, password.text, ref_code.text ?? "");
    }),
      body: SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: 0.5,

                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text("Lets Begin!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              const Text("Please Enter your credentials to proceed"),
              const SizedBox(height: 30),
              TextFormField(
                controller: email,
                cursorColor: Colors.red,
                decoration: const InputDecoration(
                  hintText: 'Your Email',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: password,
                  obscureText: true,
                  cursorColor: Colors.red,
                  decoration: const InputDecoration(
                    hintText: "Create Password",

                  )),
              const SizedBox(height: 30),
              TextFormField(
                controller: ref_code,
                  cursorColor: Colors.red,
                  decoration: const InputDecoration(
                    hintText: "Referral Code (Optional)",

                  ))

            ],
          ),
        ),
      ),
    );
  }
}
