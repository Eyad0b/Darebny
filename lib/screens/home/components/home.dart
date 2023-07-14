import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darebny/const_values.dart';
import 'package:darebny/providers/category_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/category_model.dart';
import '../../../Models/opportunity_model.dart';
import '../../../general.dart';
import '../../../providers/opportunities_provider.dart';
import '../../Training details page/Training details page.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

bool heart1IsPressed = false;
bool heart2IsPressed = false;
bool heart3IsPressed = false;

bool isSaved = false;
Map<String, bool> savedOpportunities = {};

class _BodyState extends State<Body> {
  late double width, height;

  //try 1
  // final CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('Opportunities');
  // late Future<List<Object?>> opportunities;

  //try 2
  // final Stream<QuerySnapshot> _opportunitiesStream = FirebaseFirestore.instance
  //     .collection('Opportunities')
  //     .orderBy('timestamp', descending: true)
  //     .limit(5)
  //     .snapshots();
  final Stream<QuerySnapshot> _categoriesStream =
      FirebaseFirestore.instance.collection('Categories').snapshots();
  // final Stream<QuerySnapshot> _savedOpportunitiesStream = FirebaseFirestore
  //     .instance
  //     .collection('Opportunities')
  //     .where(FieldPath.documentId, whereIn: savedOpportunities.keys)
  //     .snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //try 1
    //getData();
    loadSavedOpportunities();
    print("SavedOppor ${savedOpportunities.entries}");
  }

  Future<void> loadSavedOpportunities() async {
    final prefs = await SharedPreferences.getInstance();

    final userRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Opportunities')
        .doc("Saved");

    final docSnapshot = await userRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null) {
        setState(() {
          savedOpportunities = data.map((key, value) => MapEntry(key, true));
          savedOpportunities.removeWhere((key, value) => value == false);
        });

        final savedIds = savedOpportunities.keys.toList();
        await prefs.setStringList('savedOpportunities', savedIds);
      }
    }
  }

  Future<void> saveSavedOpportunities() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = savedOpportunities.keys.toList();
    await prefs.setStringList('savedOpportunities', savedIds);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // Create a CollectionReference called users that references the firestore collection

    return Container(
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
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Special for you
          SizedBox(height: height * .01,),
          _buildTitleText(
            title: "Recently Added",
            margin: 1.3,
            bottomPadding: 1.5,
          ),
          SizedBox(
            // color: Colors.lime,
            height: height * .188,
            child: FutureBuilder<List<Opportunity>>(
              future: Provider.of<OpportunitiesProvider>(context).getOpportunities(),
              builder: (BuildContext context, AsyncSnapshot<List<Opportunity>> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ConsValues.THEME_4,
                    ),
                  );
                }

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.take(6).map((Opportunity opportunity) {
                    return _buildRecentlyAddedItems(opportunity: opportunity,);
                  }).toList(),
                );
              },
            ),
          ),
          // Category's
          _buildTitleText(
            title: "Category",
          ),
          SizedBox(
            height: height * .48,
            child: StreamBuilder<QuerySnapshot>(
              stream: Provider.of<CategoryProvider>(context).getCategories(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ConsValues.THEME_4,
                    ),
                  );
                }

                return GridView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(right: height * .015, left: height * .015),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    return FutureBuilder<Category>(
                      future: Provider.of<CategoryProvider>(context).getCategoryById(document.id),
                      builder: (BuildContext context, AsyncSnapshot<Category> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        }

                        return _buildCategoryItem(category: snapshot.data!,);
                      },
                    );
                  }).toList(),
                );
              },
            ),

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
        ],
      ),
    );
  }

  Widget _buildRecentlyAddedItems({
    required Opportunity opportunity,
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
                        title: opportunity.title,
                        date: opportunity.date,
                        description: opportunity.description,
                        requirements: opportunity.requirements,
                        address: opportunity.address,
                        supTitle: opportunity.supTitle,
                        backgroundImageUrl: opportunity.backgroundImageUrl,
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
                          opportunity.companyImageUrl,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(width: width * .03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          opportunity.supTitle,
                          style: TextStyle(
                            fontSize: width * .03,
                            color: ConsValues.THEME_3.withOpacity(.8),
                            fontWeight: FontWeight.bold,
                            fontFamily: "muli",
                          ),
                        ),
                        Text(
                          opportunity.title,
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
              InkWell(
                onTap: () async {
                  final userRef = FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('Opportunities')
                      .doc("Saved");

                  if (savedOpportunities.containsKey(opportunity.documentId) &&
                      savedOpportunities[opportunity.documentId]!) {
                    await userRef.update({
                      opportunity.documentId: FieldValue.delete(),
                    });

                    setState(() {
                      savedOpportunities.remove(opportunity.documentId);
                    });
                  } else {
                    await userRef.set({
                      opportunity.documentId: opportunity.documentId,
                    }, SetOptions(merge: true));

                    setState(() {
                      savedOpportunities[opportunity.documentId] = true;
                    });
                  }
                },
                child: Icon(
                  savedOpportunities.containsKey(opportunity.documentId) &&
                      savedOpportunities[opportunity.documentId]!
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: ConsValues.THEME_3,
                ),
              ),
            ],
          ),
          SizedBox(height: height * .02),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: ConsValues.THEME_3,
                size: 15,
              ),
              SizedBox(width: width * .02),
              Text(
                opportunity.address,
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
                width: width * .2,
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
                  opportunity.category1,
                  style: TextStyle(
                    color: ConsValues.THEME_3,
                    fontSize: width * .03,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: width * .02),
              Container(
                width: width * .2,
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
                  opportunity.category2,
                  style: TextStyle(
                    color: ConsValues.THEME_3,
                    fontSize: width * .03,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required Category category,
  }) {
    return Container(
      margin: EdgeInsets.only(
        left: width * .02,
        top: height * .01,
        right: width * .02,
        bottom: height * .01,
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
          Image.network(
            category.imageUrl,
            width: width * .15,
            height: height * .075,
            fit: BoxFit.fill,
          ),
          SizedBox(height: width * .015),
          Text(
            category.name,
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
// try 1
// Future<void> getData() async {
//   // Get docs from collection reference
//   QuerySnapshot querySnapshot = await _collectionRef.get();
//
//   // Get data from docs and convert map to List
//   final opportunities = querySnapshot.docs.map((doc) => doc.data()).toList();
//
//   print(opportunities);
// }
}
