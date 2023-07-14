import 'package:darebny/const_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ConsValues.THEME_5,
          ),
        ),
        elevation: 0,
        backgroundColor: ConsValues.WHITE,
        iconTheme: IconThemeData(color: ConsValues.THEME_5),
      ),
      body: SingleChildScrollView(
        child: Container(
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
              ),
            ],
          ),
          width: width,
          height: height,
          padding: EdgeInsets.only(top: height * .05),
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(height * .015),
                margin: EdgeInsets.only(
                    left: height * .01,
                    right: height * .01,
                    top: height * .02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.125),
                      // spreadRadius: 0,
                      blurRadius: Checkbox.width,
                      // offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ListTile(
                  // leading: const Icon(Icons.list),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.close,
                          color: ConsValues.THEME_5.withOpacity(.6),
                          size: 15,
                        ),
                      ),
                      Text(
                        "Time",
                        style: TextStyle(
                          color: ConsValues.THEME_5.withOpacity(.6),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  title: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width * .15,
                            height: height * .075,
                            decoration: ShapeDecoration(
                                color: ConsValues.WHITE,
                                shape: const CircleBorder(
                                    side: BorderSide(color: Colors.white)),
                                shadows: const <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.white,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: Checkbox.width,
                                  ),
                                ],
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logo_wite.png"),
                                    fit: BoxFit.scaleDown)),
                          ),
                          SizedBox(
                            width: width * .05,
                          ),
                          const Column(
                            children: [
                              Text(
                                "New Opportunity uploaded",
                                style:
                                    TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "New Opportunity uploaded",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
