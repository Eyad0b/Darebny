import 'package:darebny/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool pass = false;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          color: Color.fromRGBO(218, 218, 218, 0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 75),
              Image.asset(
                "lib/assets/images/logo.png",
                height: 172,
                width: 189,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Sign in",
                style: TextStyle(
                    color: Colors.black,
                    height: 1.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 15),
              Container(
                height: 56,
                width: screenSize.width / 1.1,
                child: TextField(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 25),
                        border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        hintText: 'abc@gmail.com',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          size: 30,
                          color: Colors.grey,
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 56,
                width: screenSize.width / 1.1,
                child: TextField(
                    obscureText: !pass,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 25),
                        border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        labelStyle: TextStyle(color: Colors.grey.shade800),
                        hintText: 'Your Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                pass = !pass;
                              });
                            },
                            icon: Icon(
                              pass ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                              size: 30,
                            )))),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.black,
                    height: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 56,
                  width: screenSize.width / 1.3,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          backgroundColor:
                          MaterialStateProperty.all(Color.fromRGBO(205, 67, 58, 1))),
                      onPressed: () {},
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(color: Colors.white),
                      ))),
              SizedBox(
                height: 20,
              ),
              Text(
                "Or continue with",
                style: TextStyle(
                    color: Colors.black,
                    height: 1.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        UniconsLine.google,
                        color: Colors.red,
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                        size: 35,
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don\'t have an account?"),
                  TextButton(
                    onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          height: 1.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}