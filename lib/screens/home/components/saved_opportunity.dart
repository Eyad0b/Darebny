
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darebny/screens/home/components/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../const_values.dart';
import '../../Training details page/Training details page.dart';

class SavedOpportunity extends StatefulWidget {
  const SavedOpportunity({super.key});

  @override
  State<SavedOpportunity> createState() => _SavedOpportunityState();
}

late double width, height;

class _SavedOpportunityState extends State<SavedOpportunity> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
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
      child: StreamBuilder<QuerySnapshot>(
        stream: savedOpportunities.isNotEmpty
            ? FirebaseFirestore.instance
                .collection('Opportunities')
                .where(FieldPath.documentId, whereIn: savedOpportunities.keys)
                .snapshots()
            : null,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          final docs = snapshot.data?.docs ?? [];

          if (savedOpportunities.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/No data.gif',
                  height: height * .4,
                ),
                const SizedBox(height: 8),
                Text(
                  'No saved opportunities yet !',
                  style: TextStyle(
                    color: ConsValues.THEME_5,
                    fontSize: width * .05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  'press save icon on any opportunity to move it here.',
                  style: TextStyle(
                    color: ConsValues.THEME_5,
                    fontSize: width * .03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          }

          final filteredDocs = docs.where((document) {
            final documentId = document.id;
            return savedOpportunities.containsKey(documentId) &&
                savedOpportunities[documentId]!;
          });
//
          return Padding(
            padding: EdgeInsets.only(top: height * .03,left: width * .03,right: width * .03,),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: filteredDocs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                print("Data.tostring() =  ${FirebaseAuth.instance.currentUser!.uid}");
                return _buildSavedOpportunityItems(
                  title: data['title'] ?? "null",
                  supTitle: data['supTitle'] ?? "null",
                  address: data['address'] ?? "null",
                  companyImageUrl: data['companyImageUrl'] ?? "null",
                  requirements: data['requirements'] ?? "null",
                  description: data['description'] ?? "null",
                  date: data['date'],
                  backgroundImageUrl: data['backgroundImageUrl'] ?? "null",
                  category1: data["category1"] ?? "null",
                  category2: data["category2"] ?? "null",
                  documentId: document.id,
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSavedOpportunityItems({
    required String title,
    required String supTitle,
    required String companyImageUrl,
    required String address,
    required String requirements,
    required String description,
    required String date,
    required String backgroundImageUrl,
    required String category1,
    required String category2,
    required String documentId,
  }) {
    return Container(
      // height: height * .2,
      padding: EdgeInsets.all(height * .015),
      margin: EdgeInsets.only(
          left: height * .01, right: height * .01, top: height * .02),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: width * .15,
                      height: height * .075,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
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
                          child: SvgPicture.network(
                            companyImageUrl,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * .05),
                    Flexible(
                      child: InkWell(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * .01),
                            Text(
                              date,
                              style: TextStyle(
                                color: Colors.red.shade800,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: height * .01),
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: height * .01),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey[500],
                                  size: 15,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  address,
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .01),
                            Row(
                              children: [
                                Container(
                                  width: width * .2,
                                  height: height * .035,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: ConsValues.THEME_3.withOpacity(.5),
                                    backgroundBlendMode: BlendMode.multiply,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(width * .02),
                                    ),
                                  ),
                                  child: Text(
                                    category1,
                                    style: TextStyle(
                                      color: ConsValues.THEME_5,
                                      fontSize: width * .03,
                                      fontWeight: FontWeight.w600,
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
                                    color: ConsValues.THEME_3.withOpacity(.5),
                                    backgroundBlendMode: BlendMode.multiply,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(width * .02),
                                    ),
                                  ),
                                  child: Text(
                                    category2,
                                    style: TextStyle(
                                      color: ConsValues.THEME_5,
                                      fontSize: width * .03,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final userRef = FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('Opportunities')
                      .doc("Saved");

                  if (savedOpportunities.containsKey(documentId) &&
                      savedOpportunities[documentId]!) {
                    await userRef.update({
                      documentId: FieldValue.delete(),
                    });

                    setState(() {
                      savedOpportunities.remove(documentId);
                    });
                  } else {
                    await userRef.set({
                      documentId: documentId,
                    }, SetOptions(merge: true));

                    setState(() {
                      savedOpportunities[documentId] = true;
                    });
                  }
                },
                child: AnimatedContainer(
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ConsValues.THEME_4,
                    ),
                  ),
                  child: Center(
                      child: Icon(
                    savedOpportunities.containsKey(documentId) &&
                            savedOpportunities[documentId]!
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: ConsValues.THEME_4,
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

}
