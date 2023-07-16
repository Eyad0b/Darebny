import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darebny/screens/admin/components/admin_update_opportunity_form.dart';
import 'package:darebny/screens/home/components/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Models/opportunity_model.dart';
import '../../../const_values.dart';
import '../../../providers/opportunities_provider.dart';
import '../Training details page/Training details page.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

late double width, height;

class _AdminScreenState extends State<AdminScreen> {
  // final Stream<QuerySnapshot> _opportunitiesStream = FirebaseFirestore.instance
  //     .collection('Opportunities')
  //     .snapshots();

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
      child: Padding(
        padding: EdgeInsets.only(
          top: height * .03,
          left: width * .03,
          right: width * .03,
        ),
        child: FutureBuilder<List<Opportunity>>(
          future:
              Provider.of<OpportunitiesProvider>(context).getOpportunities(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Opportunity>> snapshot) {
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
              scrollDirection: Axis.vertical,
              children: snapshot.data!.map((Opportunity opportunity) {
                return _buildAllOpportunityItems(
                  opportunity: opportunity,
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAllOpportunityItems({
    required Opportunity opportunity,
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
                                  title: opportunity.title,
                                  date: opportunity.date,
                                  description: opportunity.description,
                                  requirements: opportunity.requirements,
                                  address: opportunity.address,
                                  supTitle: opportunity.supTitle,
                                  backgroundImageUrl:
                                      opportunity.backgroundImageUrl,
                                ),
                              ),
                            );
                          },
                          child: SvgPicture.network(
                            opportunity.companyImageUrl,
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
                                title: opportunity.title,
                                date: opportunity.date,
                                description: opportunity.description,
                                requirements: opportunity.requirements,
                                address: opportunity.address,
                                supTitle: opportunity.supTitle,
                                backgroundImageUrl:
                                    opportunity.backgroundImageUrl,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * .01),
                            Text(
                              opportunity.date,
                              style: TextStyle(
                                color: Colors.red.shade800,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: height * .01),
                            Text(
                              opportunity.title,
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
                                  opportunity.address,
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
                                    opportunity.category1,
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
                                    opportunity.category2,
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
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminUpdateOpportunityForm(),
                        ),
                      );
                    },
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: ConsValues.THEME_4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .07,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminUpdateOpportunityForm(),
                        ),
                      );
                    },
                    child: Center(
                      child: Icon(
                        Icons.edit,
                        color: ConsValues.THEME_4,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width * .02,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
