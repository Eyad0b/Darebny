import 'package:darebny/const_values.dart';
import 'package:darebny/screens/RessetPassword.dart';
import 'package:darebny/screens/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'home/home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

late double width;
late double height;

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool pass = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          color: const Color.fromRGBO(218, 218, 218, 0.39),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.gif",
                height: height * .3,
                width: width,
                fit: BoxFit.cover,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * .05,
                  ),
                  Text(
                    "Sign in",
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
                  controller: emailController, // Added controller
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
                      horizontal: 35,
                      vertical: 25,
                    ),
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
                  controller: passwordController, // Added controller
                  obscureText: !pass,
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
                      horizontal: 35,
                      vertical: 25,
                    ),
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
                          pass = !pass;
                        });
                      },
                      icon: Icon(
                        pass ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const RessetPassword()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: ConsValues.THEME_5,
                        height: 1.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
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
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const HomeScreen()),
                    // );
                    signInWithEmailAndPassword();
                  }, // Call createuser function
                  child: const Text(
                    "SIGN IN",
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
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: Text(
                      "Sign Up",
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

  void signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // final user = await FirebaseFirestore.instance
      //     .collection("Users")
      //     .doc(credential.user!.uid)
      //     .snapshots();
      //
      // user. == "1" ?
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(page: 0,)),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.cyan,
            content: Text("No user found for that email."),
            duration: Duration(seconds: 5),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.cyan,
            content: Text("Wrong password provided for that user."),
            duration: Duration(seconds: 5),
          ),
        );
      } else {
        Center(child: CircularProgressIndicator(color: ConsValues.THEME_4,),);
      }
    }
  }
}
