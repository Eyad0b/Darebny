import 'package:darebny/const_values.dart';
import 'package:darebny/general.dart';
import 'package:darebny/screens/home/components/all_opportunities.dart';
import 'package:darebny/screens/home/components/saved_opportunity.dart';
import 'package:darebny/screens/notification_screen.dart';
import 'package:darebny/screens/profile_page.dart';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../../Components/curved_button_bar.dart';
import '../drawer/drawer_screen.dart';
import '../home/components/home.dart';
import '../search_page.dart';

// globalKey
final GlobalKey<CurvedNavigationBarNewCopyForDaribnyState> _bottomNavigationKey =
GlobalKey<CurvedNavigationBarNewCopyForDaribnyState>();

class HomeScreen extends StatefulWidget {
  final int page;
  // final Function(int) onPageChanged;

  HomeScreen({required this.page,Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

late double width;
late double height;

// replace future
// getPrefInt() async {
//   var rse = await General.getPrefInt("_page", 0);
//   return rse;
// }

int _page = 0;
List<Widget> _pages = [
  const Body(),
  const AllOpportunities(),
  const SavedOpportunity(),
  const ProfilePage(),
  // const Body(),
];
// GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

class _HomeScreenState extends State<HomeScreen> {
  bool heart1IsPressed = false;
  bool heart2IsPressed = false;
  bool heart3IsPressed = false;

  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // General.savePrefInt("_page", 2);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // _page = widget.page;
    // int _page = getPrefInt();
    return Stack(
      children: [
        DrawerScreen(
          onPageChanged: (newPage) {
            setState(() {
              _page = newPage;
            });
            _bottomNavigationKey.currentState!.setPage(newPage);
          },
        ),
        AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(isDrawerOpen ? 0.8 : 1.00)
            ..rotateZ(isDrawerOpen ? -50 : 0)
          // ..rotateX(isDrawerOpen ? -10 : 0)
          ,
          curve: Curves.ease,
          // Style of animation
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            color: ConsValues.THEME_3,
            // border: Border.all(
            //   color: Color.fromRGBO(245, 232, 223, .1),
            //   width: 2,
            // ),
            shape: BoxShape.rectangle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: ConsValues.THEME_5.withOpacity(.2),
                blurStyle: BlurStyle.outer,
                blurRadius: Checkbox.width,
              ),
            ],
            borderRadius: isDrawerOpen
                ? BorderRadius.circular(80)
                : BorderRadius.circular(0),
          ),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(height * .08),
              child: _buildAppBar(),
            ),
            body: _pages[_page],
            bottomNavigationBar: _buildBottomNavigationBar(),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: height * .08,
      elevation: 0,
      backgroundColor: ConsValues.WHITE,
      titleSpacing: double.minPositive,
      leading: isDrawerOpen
          ? GestureDetector(
              child: Icon(
                Icons.arrow_back_rounded,
                color: ConsValues.THEME_5,
                size: height * .045,
              ),
              onTap: () {
                setState(() {
                  xOffset = 0;
                  yOffset = 0;
                  isDrawerOpen = false;
                });
              },
            )
          : GestureDetector(
              child: Icon(
                Icons.menu_rounded,
                color: ConsValues.THEME_5,
                size: height * .045,
              ),
              onTap: () {
                setState(() {
                  xOffset = 290;
                  yOffset = 80;
                  isDrawerOpen = true;
                });
              },
            ),
      title: const Text("Daribny"),
      titleTextStyle: TextStyle(
        color: ConsValues.THEME_5,
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
      actions: [
        Container(
          // height: height * .01,
          width: height * .05,
          margin: EdgeInsets.only(
            right: width * .05,
          ),
          decoration: BoxDecoration(
            color: ConsValues.THEME_3.withOpacity(.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            child: Icon(
              Icons.search_rounded,
              size: height * .035,
              color: ConsValues.THEME_5,
            ),
          ),
        ),
        Container(
          // height: height * .01,
          width: height * .05,
          margin: EdgeInsets.only(
            right: width * .05,
          ),
          decoration: BoxDecoration(
            color: ConsValues.THEME_3.withOpacity(.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: badges.Badge(
            position: badges.BadgePosition.custom(
                start: width * .05, bottom: width * .05),
            badgeContent: Text(
              "3",
              style: TextStyle(color: Colors.white, fontSize: height * .015),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                );
              },
              child: Icon(
                Icons.notifications_none,
                size: height * .035,
                color: ConsValues.THEME_5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    Color icon0Color = _page == 0 ? ConsValues.WHITE : ConsValues.THEME_5;
    Color icon1Color = _page == 1 ? ConsValues.WHITE : ConsValues.THEME_5;
    Color icon2Color = _page == 2 ? ConsValues.WHITE : ConsValues.THEME_5;
    Color icon3Color = _page == 3 ? ConsValues.WHITE : ConsValues.THEME_5;

    return CurvedNavigationBarNewCopyForDaribny(
      backgroundColor: Colors.grey.withOpacity(.15),
      height: height * .08,
      color: Colors.white,
      buttonBackgroundColor: ConsValues.THEME_4,
      animationCurve: Curves.decelerate,
      animationDuration: const Duration(milliseconds: 500),
      items: <Widget>[
        Container(
          margin: const EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.explore_outlined,
                size: 25,
                color: _page == 0 ? ConsValues.WHITE : ConsValues.THEME_5,
              ),
              _page != 0
                  ? Text(
                      "Home",
                      style: TextStyle(
                        color: _page == 0 ? ConsValues.WHITE : ConsValues.THEME_5,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.work_outline_rounded,
                size: 25,
                color: _page == 1 ? ConsValues.WHITE : ConsValues.THEME_5,
              ),
              _page != 1
                  ? Text(
                      "Jobs",
                      style: TextStyle(
                        color: _page == 1 ? ConsValues.WHITE : ConsValues.THEME_5,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.bookmark_border_rounded,
                size: 25,
                color:_page == 2 ? ConsValues.WHITE : ConsValues.THEME_5,
              ),
              _page != 2
                  ? Text(
                      "Saved",
                      style: TextStyle(
                        color: _page == 2 ? ConsValues.WHITE : ConsValues.THEME_5,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 25,
                color: _page == 3 ? ConsValues.WHITE : ConsValues.THEME_5,
              ),
              _page != 3
                  ? Text(
                      "Profile",
                      style: TextStyle(
                        color: _page == 3 ? ConsValues.WHITE : ConsValues.THEME_5,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
      key: _bottomNavigationKey,
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
    );
  }



}
