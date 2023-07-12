import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darebny/const_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;

import '../../Training details page/Training details page.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

bool heart1IsPressed = false;
bool heart2IsPressed = false;
bool heart3IsPressed = false;

class _BodyState extends State<Body> {
  late double width, height;

  //try 1
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Opportunities');
  late Future<List<Object?>> opportunities;

  //try 2
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Opportunities').snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //try 1
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      decoration: ShapeDecoration(
        color: Colors.grey.withOpacity(.15),
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
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Special for you
          _buildTitleText(
            title: "Recently Added",
            margin: 1.3,
            bottomPadding: 1.5,
          ),
          SizedBox(
            // color: Colors.lime,
            height: height * .188,
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return _buildRecentlyAddedItems(
                      title: data['title'] ?? "null",
                      supTitle: data['supTitle'] ?? "null",
                      address: data['address'] ?? "null",
                      companyImageUrl: data['companyImageUrl'] ?? "null",
                      requirements: data['requirements'] ?? "null",
                      description: data['description'] ?? "null",
                      date: data['date'],
                      backgroundImageUrl: data['backgroundImageUrl'] ?? "null",
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // Category's
          _buildTitleText(
            title: "Category",
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryItem(
                    title: "Medicine",
                    itemImagePath: "assets/images/medical.jpg",
                    heartIsPressed: heart1IsPressed,
                  ),
                  _buildCategoryItem(
                    title: "Engineering",
                    itemImagePath: "assets/images/engineering.jpg",
                    heartIsPressed: heart2IsPressed,
                  ),
                  _buildCategoryItem(
                    title: "Teaching",
                    itemImagePath: "assets/images/teacher.jpg",
                    heartIsPressed: heart3IsPressed,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryItem(
                    title: "Cooking",
                    itemImagePath: "assets/images/cooking.jpg",
                    heartIsPressed: heart1IsPressed,
                  ),
                  _buildCategoryItem(
                    title: "Business",
                    itemImagePath: "assets/images/Business.jpg",
                    heartIsPressed: heart2IsPressed,
                  ),
                  _buildCategoryItem(
                    title: "Arts",
                    itemImagePath: "assets/images/art.jpg",
                    heartIsPressed: heart3IsPressed,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryItem(
                    title: "Training",
                    itemImagePath: "assets/images/training.jpg",
                    heartIsPressed: heart1IsPressed,
                  ),
                  _buildCategoryItem(
                    title: "Media",
                    itemImagePath: "assets/images/media.jpg",
                    heartIsPressed: heart2IsPressed,
                  ),
                  _buildCategoryItem(
                    title: "Filmmaker",
                    itemImagePath: "assets/images/filmmaker.jpg",
                    heartIsPressed: heart3IsPressed,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleText(
      {required String title, double margin = 2.0, double bottomPadding = 2}) {
    return Container(
      height: height * .05,
      // margin: EdgeInsets.only(top: Checkbox.width / 8),
      padding: const EdgeInsets.only(
        // bottom: Checkbox.width / bottomPadding,
        left: Checkbox.width,
        right: Checkbox.width,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: "muli",
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "See More",
              style: TextStyle(
                fontSize: 15,
                color: ConsValues.BUTTON_COLOR,
                fontWeight: FontWeight.bold,
                fontFamily: "muli",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyAddedItems({
    required String title,
    required String supTitle,
    required String companyImageUrl,
    required String address,
    required String requirements,
    required String description,
    required String date,
    required String backgroundImageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        top: Checkbox.width,
        left: Checkbox.width,
        right: Checkbox.width,
      ),
      width: width * .7,
      height: height * .05,
      margin: EdgeInsets.only(
        left: width * .05,
        right: width * .03,
        // top: Checkbox.width / 4,
        // bottom:  height * .01,
      ),
      decoration: ShapeDecoration(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        // color: ConsValues.BUTTON_COLOR,
        gradient: LinearGradient(
          colors: <Color>[
            ConsValues.BUTTON_COLOR.withOpacity(.7),
            ConsValues.BUTTON_COLOR,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        // shadows: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black,
        //     blurStyle: BlurStyle.inner,
        //     // offset: Offset.fromDirection(Checkbox.width),
        //     blurRadius: Checkbox.width,
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainingDetails(
                        title: title,
                        date: date,
                        description: description,
                        requirements: requirements,
                        address: address,
                        supTitle: supTitle,
                        backgroundImageUrl: backgroundImageUrl,
                      ),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: width * .1,
                        height: height * .05,
                        padding: const EdgeInsets.all(Checkbox.width / 2),
                        decoration: BoxDecoration(
                          color: ConsValues.THEME_3,
                          borderRadius: BorderRadius.all(
                            Radius.circular(width * .02),
                          ),
                        ),
                        child: SvgPicture.network(
                          companyImageUrl,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(width: width * .03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          supTitle,
                          style: TextStyle(
                            fontSize: width * .03,
                            color: ConsValues.THEME_3.withOpacity(.8),
                            fontWeight: FontWeight.bold,
                            fontFamily: "muli",
                          ),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: width * .04,
                            color: ConsValues.THEME_3,
                            fontWeight: FontWeight.bold,
                            fontFamily: "muli",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.bookmark_border,
                color: ConsValues.THEME_3,
              ),
            ],
          ),
          SizedBox(height: height * .02),
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/Location point.svg",
                color: ConsValues.THEME_3,
              ),
              SizedBox(width: width * .02),
              Text(
                address,
                style: TextStyle(
                  color: ConsValues.THEME_3,
                  fontSize: width * .03,
                ),
              ),
            ],
          ),
          SizedBox(height: height * .02),
          Row(
            children: [
              Container(
                width: width * .15,
                height: height * .035,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  backgroundBlendMode: BlendMode.lighten,
                  borderRadius: BorderRadius.all(
                    Radius.circular(width * .02),
                  ),
                ),
                child: Text(
                  "data",
                  style: TextStyle(
                    color: ConsValues.THEME_3,
                    fontSize: width * .03,
                  ),
                ),
              ),
              SizedBox(width: width * .02),
              Container(
                width: width * .15,
                height: height * .035,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  backgroundBlendMode: BlendMode.lighten,
                  borderRadius: BorderRadius.all(
                    Radius.circular(width * .02),
                  ),
                ),
                child: Text(
                  "data",
                  style: TextStyle(
                    color: ConsValues.THEME_3,
                    fontSize: width * .03,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
      {required String title,
      required String itemImagePath,
      required bool heartIsPressed}) {
    return Container(
      margin: EdgeInsets.only(
        // left: width * .025,
        top: height * .00525,
        // right: width * .025,
        bottom: width * .015,
      ),
      width: width * .27,
      height: height * .13,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Colors.grey.shade300),
          borderRadius: const BorderRadius.all(
            Radius.circular(Checkbox.width),
          ),
        ),
        shadows: <BoxShadow>[
          BoxShadow(
            color: ConsValues.THEME_5.withOpacity(.1),
            blurStyle: BlurStyle.outer,
            blurRadius: Checkbox.width / 2,
          ),
        ],
        color: ConsValues.WHITE,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            itemImagePath,
            width: width * .15,
            height: height * .075,
          ),
          SizedBox(height: width * .015),
          Text(
            title,
            style: TextStyle(
              fontSize: width * .03,
              color: ConsValues.THEME_5,
              fontWeight: FontWeight.bold,
              fontFamily: "muli",
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final opportunities = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(opportunities);
  }
}
