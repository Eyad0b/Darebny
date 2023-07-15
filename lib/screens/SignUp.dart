import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darebny/const_values.dart';
import 'package:darebny/screens/SignIn.dart';
import 'package:darebny/screens/Training%20details%20page/Training%20details%20page.dart';
import 'package:darebny/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unicons/unicons.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

late double width;
late double height;

class _SignUpState extends State<SignUp> {
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(218, 218, 218, 0.39),
        iconTheme: IconThemeData(color: ConsValues.THEME_5),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          color: const Color.fromRGBO(218, 218, 218, 0.39),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "  Sign Up",
                    style: TextStyle(
                      color: ConsValues.THEME_5,
                      height: 1.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: height * .08,
                width: width * .9,
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ConsValues.THEME_5,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 25),
                    border: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(color: Colors.grey.shade800),
                    ),
                    hintText: 'Full Name',
                    prefixIcon: const Icon(
                      UniconsLine.user,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: height * .08,
                width: width * .9,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ConsValues.THEME_5,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 25),
                    border: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(color: Colors.grey.shade800),
                    ),
                    hintText: 'abc@gmail.com',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: height * .08,
                width: width * .9,
                child: TextField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ConsValues.THEME_5,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 25),
                    border: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(color: Colors.grey.shade800),
                    ),
                    labelStyle: TextStyle(color: Colors.grey.shade800),
                    hintText: 'Your Password',
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: height * .08,
                width: width * .9,
                child: TextField(
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ConsValues.THEME_5,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 25),
                    border: OutlineInputBorder(
                      gapPadding: 10,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide(color: Colors.grey.shade800),
                    ),
                    labelStyle: TextStyle(color: Colors.grey.shade800),
                    hintText: 'Confirm Password',
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 20),
              SizedBox(
                height: height * .07,
                width: width * .7,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(205, 67, 58, 1)),
                  ),
                  onPressed: () => createUserWithEmailAndPassword(),
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Or continue with",
                style: TextStyle(
                  color: ConsValues.THEME_5,
                  height: 1.0,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: height * .08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/google-icon.svg",
                      width: height * .035,
                      height: height * .035,
                      // fit: BoxFit.fitHeight,
                    ),
                    SizedBox(width: width * .15),
                    Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: height * .045,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: ConsValues.THEME_5,
                        height: 1.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createUserWithEmailAndPassword() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (credential.user != null) {
        credential.user!.updateDisplayName(usernameController.text);
        setState(() {});
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(credential.user!.uid)
            .set({
          "Name": usernameController.text,
          "Email": emailController.text,
          "Password": passwordController.text,
          "UserType" : "1",
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(page: 0,)),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The password provided is too weak."),
            duration: Duration(seconds: 2),
          ),
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The account already exists for that email."),
            duration: Duration(seconds: 2),
          ),
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
