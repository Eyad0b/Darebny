import 'dart:async';

import 'package:darebny/screens/SignIn.dart';
import 'package:darebny/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../const_values.dart';
import '../general.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    //set time to loade the new page
    // Future.delayed(Duration(seconds: 6), () {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => SignIn()));
    // });
    super.initState();
    checkUserLogin();
  }

  checkUserLogin() {
    General.getPrefString(ConsValues.USER_ID, "").then(
      (value) {
        if (value == "") {
          Timer(
            const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => SignIn(),
              ),
            ),
          );
        } else if (value.isNotEmpty) {
          Timer(
            const Duration(seconds: 3),
                () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(page: 0),
              ),
            ),
          );
        } else {
          General.getPrefString(ConsValues.USER_TYPE, "").then(
            (value) {
              if (value == "1") {
                Timer(
                  const Duration(seconds: 3),
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen(page: 0),
                    ),
                  ),
                );
              } else {
                
                // Timer(
                //   const Duration(seconds: 3),
                //       () => Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //       builder: (BuildContext context) =>
                //       const AdminMainScreen(),
                //     ),
                //   ),
                // );
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(218, 218, 218, 0.39),
        width: screenSize.width,
        height: screenSize.height,
        child: Image.asset(
          "assets/images/logo.gif",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
