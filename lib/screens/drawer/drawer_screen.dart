import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../const_values.dart';
import '../../general.dart';

class DrawerScreen extends StatefulWidget {
  final Function(int) onPageChanged;

  const DrawerScreen({required this.onPageChanged, Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: ConsValues.WHITE,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, bottom: 70),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(Checkbox.width * 2.5),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              blurStyle: BlurStyle.outer,
                              blurRadius: Checkbox.width,
                              color: ConsValues.THEME_5.withOpacity(.1)),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: Checkbox.width * 2.5,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Checkbox.width * 2.5),
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/darebny-42086.appspot.com/o/assets%2Fimages%2Fcategories%2Ftechnology.png?alt=media&token=1299b6ca-4968-4b7b-90cc-a2a0c97dd3c5",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName
                              .toString() ??
                          "null",
                      style: TextStyle(
                        color: ConsValues.THEME_5,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .08),
                Column(
                  children: <Widget>[
                    const InkWell(
                      child: NewRow(
                        text: 'Settings',
                        icon: Icons.error_outline,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.onPageChanged(3);
                        });
                      },
                      child: const NewRow(
                        text: 'My Profile',
                        icon: Icons.person_outline,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const NewRow(
                      text: 'Applied',
                      icon: Icons.done_all_outlined,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.onPageChanged(2);
                        });
                      },
                      child: const NewRow(
                        text: 'Saved',
                        icon: Icons.bookmark_border,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        await General.remove(ConsValues.USER_NAME);
                        await General.remove(ConsValues.USER_ID);
                        await General.remove(ConsValues.USER_EMAIL);
                        await General.remove(ConsValues.USER_TYPE);
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pop();
                        // AlertDialog(
                        //   content: const Text("Are you sure?"),
                        //   actions: [
                        //     TextButton(
                        //       child: const Text('No'),
                        //       onPressed: () {
                        //         Navigator.pop(context);
                        //       },
                        //     ),
                        //     TextButton(
                        //       child: const Text('Yes'),
                        //       onPressed: () async {
                        //         await FirebaseAuth.instance.signOut();
                        //         Navigator.of(context).pop();
                        //         Navigator.pop(context);
                        //       },
                        //     )
                        //   ],
                        // );
                        //   AwesomeDialog(
                        //     context: context,
                        //     dialogType: DialogType.warning,
                        //     animType: AnimType.topSlide,
                        //     title: 'Are you sure ?',
                        //     desc: 'Do you want to log out of the application?',
                        //     btnCancelText: "No",
                        //     btnCancelOnPress: () {
                        //       Navigator.of(context).pop();
                        //     },
                        //     btnOkText: "Yes",
                        //     btnOkOnPress: () async {
                        //       await FirebaseAuth.instance.signOut();
                        //       Navigator.of(context).pop();
                        //       Navigator.of(context).pop();
                        //     },
                        //   );
                      },
                      child: const NewRow(
                        text: 'Sign Out',
                        icon: Icons.cancel_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const NewRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: ConsValues.THEME_5,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(
            color: ConsValues.THEME_5,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
