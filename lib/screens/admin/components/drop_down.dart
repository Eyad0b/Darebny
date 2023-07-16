import 'package:flutter/material.dart';

class DropDownMain extends StatefulWidget {
  DropDownMain(
      {super.key,
        required this.hintText,
        required this.itemsChoose,
        this.selectedItem});
  final String hintText;
  var selectedItem;
  final List<String> itemsChoose;

  @override
  State<DropDownMain> createState() => _DropDownMainState();
}

class _DropDownMainState extends State<DropDownMain> {
  @override
  Widget build(BuildContext context) {
    final themeDropDown = Theme.of(context);
    late double width = MediaQuery.of(context).size.height;
    late double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width * .2,
      height: height * .07,
      child: DropdownButtonFormField(
        validator: (valueEnter) {
          if (valueEnter == null) {
            return 'Please Choose the properties inside the Filed';
          }
          setState(() {
            widget.selectedItem = valueEnter;
          });
        },
        menuMaxHeight: 200,
        decoration: InputDecoration(
          // hintStyle: themeDropDown.dropdownMenuTheme.textStyle?.copyWith(
          //   color: ColorsThemeApp.darkApp,
          // ),
            hintText: widget.hintText,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 25,
        ),
        elevation: 0,
        style: themeDropDown.dropdownMenuTheme.textStyle,
        items: widget.itemsChoose
            .map((a) => DropdownMenuItem(
          child: Text("$a",
              style: themeDropDown.textTheme.bodyMedium
                  ?.copyWith(color: Colors.black)),
          value: a,
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            widget.selectedItem = value;
          });
        },
        value: widget.selectedItem,
      ),
    );
  }
}