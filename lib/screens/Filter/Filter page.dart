import 'package:darebny/const_values.dart';
import 'package:darebny/screens/Filter/Filter%20widget.dart';
import 'package:flutter/material.dart';

class FilterPag extends StatefulWidget {
  const FilterPag({super.key});

  @override
  State<FilterPag> createState() => _FilterPagState();
}

class _FilterPagState extends State<FilterPag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      decoration: const ShapeDecoration(
        color: Color.fromRGBO(218, 218, 218, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            // topRight: Radius.circular(40),
          ),
        ),
        shadows: <BoxShadow>[
          BoxShadow(
            color: Colors.white,
            blurStyle: BlurStyle.outer,
            blurRadius: Checkbox.width,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .65,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(228, 225, 225, 0.973),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const title(),
                  const IconsFields(),
                  // place(),
                  // placeOption(),
                  // trainingstate(),
                  // trainingOption(),
                  const Location(),
                  locationOptions(),
                  const ApplyBotton(),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
