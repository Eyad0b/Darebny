import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darebny/const_values.dart';
import 'package:flutter/material.dart';
import 'drop_down.dart';

class AdminUpdateOpportunityForm extends StatefulWidget {
  static const routeName = 'PageAdmin';

  const AdminUpdateOpportunityForm({super.key});

  @override
  State<AdminUpdateOpportunityForm> createState() =>
      _AdminUpdateOpportunityFormState();
}

late double width;
late double height;

class _AdminUpdateOpportunityFormState
    extends State<AdminUpdateOpportunityForm> {
  TextEditingController address = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController req = TextEditingController();
  TextEditingController supTitle = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController companyImageURL = TextEditingController();
  TextEditingController backgroundImageUrl = TextEditingController();
  GlobalKey<FormState> globalData = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  String selectedCategory1 = '';
  String selectedCategory2 = '';

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Form(
        key: globalData,
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: ConsValues.THEME_5),
                centerTitle: true,
                backgroundColor: ConsValues.WHITE,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Row(children: [
                          Text(
                            'Enter the title',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Please Enter your title valid and Larger then 6 char ';
                            }
                            return null;
                          },
                          controller: title,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.title_rounded),
                            hintText: 'Title',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Row(children: [
                          Text(
                            'Enter the Company Url',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 2) {
                              return 'Please Enter your company url valid and Larger then 2 char ';
                            }
                            return null;
                          },
                          controller: companyImageURL,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.title_rounded),
                            hintText: 'Company Url',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          keyboardType: TextInputType.url,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Row(children: [
                          Text(
                            'Enter Background Image Url ',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return 'Please Enter your company url valid and Larger then 8 char ';
                            }
                            return null;
                          },
                          controller: backgroundImageUrl,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.title_rounded),
                            hintText: 'Background Image Url',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          keyboardType: TextInputType.url,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropDownMain(
                              hintText: 'Category',
                              itemsChoose: const [
                                'Arts',
                                'Business',
                                'Cooking',
                                'Engineering',
                                'Filmmaker',
                                'Media',
                                'Medicine',
                                'Teaching',
                                'Technology',
                                'Training',
                              ],
                              //
                              // onChanged: (value) {
                              //   setState(() {
                              //     selectedCategory1 = value;
                              //   });
                              // },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DropDownMain(
                              hintText: 'Category',
                              itemsChoose: const [
                                'Arts',
                                'Business',
                                'Cooking',
                                'Engineering',
                                'Filmmaker',
                                'Media',
                                'Medicine',
                                'Teaching',
                                'Technology',
                                'Training',
                              ],
                              // onChanged: (value) {
                              //   setState(() {
                              //     selectedCategory2 = value;
                              //   });
                              // },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Row(children: [
                          Text(
                            'Enter the Address',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please Enter your Address valid and Larger then 4 char ';
                            }
                            return null;
                          },
                          controller: address,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ConsValues.THEME_5,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            prefixIconColor: ConsValues.THEME_5,
                            prefixIcon: const Icon(Icons.location_on),
                            hintText: 'Address',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Row(children: [
                          Text(
                            'Enter the date Time',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return 'Please Enter your Date valid and Larger then 8 char ';
                            }
                            return null;
                          },
                          controller: date,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ConsValues.THEME_5,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            prefixIconColor: ConsValues.THEME_5,
                            prefixIcon: IconButton(
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: dateTime,
                                  firstDate: DateTime(1970),
                                  lastDate: DateTime(2040),
                                );
                                if (newDate == null) {
                                  return;
                                }
                              },
                              icon: const Icon(Icons.date_range_rounded),
                            ),
                            hintText: 'Date',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Row(children: [
                          Text(
                            'Enter the description',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 12) {
                              return 'Please Enter your desc valid and Larger then 12 char ';
                            }
                            return null;
                          },
                          controller: desc,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ConsValues.THEME_5,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            prefixIconColor: ConsValues.THEME_5,
                            prefixIcon: const Icon(Icons.description),
                            hintText: 'Descriptions',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Row(children: [
                          Text(
                            'Enter the Requirements',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Please Enter your desc valid and Larger then 6 char ';
                            }
                            return null;
                          },
                          controller: req,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ConsValues.THEME_5,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            prefixIconColor: ConsValues.THEME_5,
                            prefixIcon: const Icon(Icons.add),
                            hintText: 'Requirements',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 15),
                        child: Row(children: [
                          Text(
                            'Enter the SupTitle',
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please Enter your desc valid and Larger then 14 char ';
                            }
                            return null;
                          },
                          controller: supTitle,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ConsValues.THEME_5,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            prefixIconColor: ConsValues.THEME_5,
                            prefixIcon: const Icon(Icons.title),
                            hintText: 'SupTitle',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 56,
                        width: 300,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(205, 67, 58, 1)),
                          ),
                          onPressed: () {
                            // Step 3: Retrieve Data from Text Fields
                            String titleText = title.text;
                            String addressText = address.text;
                            String companyUrl = companyImageURL.text;
                            String backgroundImageUrlText = backgroundImageUrl.text;
                            String descText = desc.text;
                            String supTitleText = supTitle.text;
                            String reqText = req.text;
                            String dateText = date.text;

                            // Step 4: Create a Data Object (map) to represent the opportunity
                            Map<String, dynamic> opportunityData = {
                              'title': titleText,
                              'address': addressText,
                              'companyUrl': companyUrl,
                              'backgroundImageUrl': backgroundImageUrlText,
                              'desc': descText,
                              'supTitle': supTitleText,
                              'req': reqText,
                              'date':dateText,
                              'category1': selectedCategory1,
                              'category2': selectedCategory2,
                              // Add other fields here
                            };

                            // Step 5: Add Data to Firestore
                            FirebaseFirestore.instance
                                .collection('Opportunities')
                                .add(opportunityData)
                                .then((docRef) {
                              // Success! Document added to Firestore.
                              print('Opportunity added with ID: ${docRef.id}');
                              // You can also navigate to the next page here if needed.
                            }).catchError((error) {
                              // Handle any errors that occur while adding data to Firestore.
                              print('Error adding opportunity to Firestore: $error');
                            });
                          },
                          child: const Text(
                            "Next Page",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
        );
    }
}