import 'package:darebny/const_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:darebny/screens/home/home_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

late double width;
late double height;

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showPassword = false;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _fullNameHint = "";
  String _emailHint = "";
  String _passwordHint = "";

  @override
  void initState() {
    super.initState();
    fetchHintTexts();
  }

  Future<void> fetchHintTexts() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot documentSnapshot =
            await _firestore.collection('Users').doc(user.uid).get();

        setState(() {
          _fullNameHint = documentSnapshot.get('name') ?? "";
          _emailHint = documentSnapshot.get('Email') ?? "";
          _passwordHint = documentSnapshot.get('Password') ?? "";
        });
      }
    } catch (error) {
      print('Error fetching hint texts: $error');
    }
  }

  Future<void> saveData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot documentSnapshot =
            await _firestore.collection('Users').doc(user.uid).get();

        Map<String, dynamic> existingData =
            (documentSnapshot.data() as Map<String, dynamic>) ?? {};

        Map<String, dynamic> newData = {
          'name': _fullNameController.text.isNotEmpty
              ? _fullNameController.text
              : existingData['name'],
          'Email': _emailController.text.isNotEmpty
              ? _emailController.text
              : existingData['Email'],
          'Password': _passwordController.text.isNotEmpty
              ? _passwordController.text
              : existingData['Password'],
        };
        //
        FirebaseAuth.instance.currentUser!.updateDisplayName(_fullNameController.text.isNotEmpty
            ? _fullNameController.text : _fullNameHint);
        FirebaseAuth.instance.currentUser!.updateEmail(_emailController.text.isNotEmpty
            ? _emailController.text : _emailHint);
        FirebaseAuth.instance.currentUser!.updatePassword(_passwordController.text.isNotEmpty
            ? _passwordController.text : _passwordHint);


        await _firestore.collection('Users').doc(user.uid).update(newData);
        print('Data saved successfully!');
      }
    } catch (error) {
      print('Error saving data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ConsValues.WHITE,
      body: Container(
        decoration: ShapeDecoration(
          color: ConsValues.BACKGROUND_COLOR,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          shadows: const <BoxShadow>[
            BoxShadow(
              color: Colors.white,
              blurStyle: BlurStyle.outer,
              blurRadius: Checkbox.width,
              offset: Offset(2, 2),
              // spreadRadius: Checkbox.width,
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.15),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        height: height * 0.7,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double innerHeight = constraints.maxHeight;
                            double innerWidtht = constraints.maxWidth;
                            return Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Container(
                                      height: innerHeight * 0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: height * .05),
                                          const Text(
                                            "Edit Profile",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: height * .03),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 70,
                                              right: 70,
                                            ),
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: _fullNameController,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                      bottom: 3,
                                                    ),
                                                    labelText: "Full Name",
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    hintText: _fullNameHint,
                                                    hintStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: ConsValues.THEME_5,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height * .03),
                                                TextField(
                                                  controller: _emailController,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                      bottom: 3,
                                                    ),
                                                    labelText: "Email",
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    hintText: _emailHint,
                                                    hintStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: ConsValues.THEME_5,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height * .03),
                                                TextField(
                                                  controller: _passwordController,
                                                  obscureText: !showPassword,
                                                  obscuringCharacter: "*",
                                                  decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        setState(
                                                          () {
                                                            showPassword =
                                                                !showPassword;
                                                          },
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove_red_eye,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                      bottom: 3,
                                                    ),
                                                    labelText: "Password",
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    hintText: "******",
                                                    //_passwordHint,
                                                    hintStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: ConsValues.THEME_5,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 05),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(30),
                                                  child: SizedBox(
                                                    height: 50,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        1.3,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              15,
                                                            ),
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                          ConsValues.THEME_4,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        saveData();
                                                      },
                                                      child: Text(
                                                        "Save",
                                                        style: TextStyle(
                                                            color:
                                                                ConsValues.WHITE,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              ConsValues.BACKGROUND_COLOR,
                                          radius: innerWidtht * 0.19,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Checkbox.width * 2.5),
                                            child: Image.network(
                                              "https://firebasestorage.googleapis.com/v0/b/darebny-42086.appspot.com/o/assets%2Fimages%2Fcategories%2Ftechnology.png?alt=media&token=1299b6ca-4968-4b7b-90cc-a2a0c97dd3c5",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 4,
                                          right: 4,
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 4,
                                                  color: ConsValues.WHITE),
                                              color: ConsValues.THEME_4,
                                            ),
                                            child: Center(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: ConsValues.WHITE,
                                                  size: 20,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
