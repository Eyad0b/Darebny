
import 'package:flutter/material.dart';

import '../const_values.dart';
import 'listing_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}
late double width;
late double height;
class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ConsValues.WHITE,
      body: Container(
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
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: IconThemeData(color: ConsValues.THEME_5),
              backgroundColor: ConsValues.WHITE,
              elevation: 0,
              leadingWidth: 20,
              title: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: width * .06,right: width * .06,bottom: height * .015,top:height * .025),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    SizedBox(
                      height: height * .06,
                      width: width * .75,
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: width * .06, vertical: 0),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search e.g Software Developer",
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    //SizedBox(width: 5,),
                    Spacer(),
                    Container(
                      width: width * .1,
                      height: height * .05,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ConsValues.BUTTON_COLOR,//Colors.red.shade800,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () { },
                          icon: Icon(Icons.filter_list_rounded,color: Colors.white,size: 23,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: width * .06,right: width * .06,bottom: height * .015,top:height * .025),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return JobComponent(job: jobList[index]);
                  },
                  childCount: jobList.length,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
