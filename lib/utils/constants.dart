import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//? Full Screen Size
late Size screenSize;

//? Border Radius's
const double smallestBorderRadius = 4;
const double smallBorderRadius = 20;
const double mediumBoardRadius = 30;
const double largeBorderRadius = 50;

//? Table
const TextAlign tableTextAlign = TextAlign.center;
const TableCellVerticalAlignment tableCellVerticalAlignment =
    TableCellVerticalAlignment.middle;

TextStyle tableHeadingTextStyle(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .bodyLarge!
      .copyWith(fontWeight: FontWeight.bold);
}

//? Paddings
const double smallestPadding = 5;
const double smallPadding = 10;
const double mediumPadding = 20;
const double largePadding = 30;

//? Buttons Size
const Size buttonSize = Size(50, 50);
const customButtonTextPadding =
    MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: mediumPadding));

//? Request Time Out Duration
const Duration timeOutDuration = Duration(seconds: 30);

//? Error Flutter Toast
Future<bool?> showErrorToast({required String msg}) => Fluttertoast.showToast(
    msg: msg, backgroundColor: Colors.redAccent, textColor: Colors.white);

//? Prefixed Value for Contact
String get contactFieldDefaultValue => '+92 ';

//? Branch Name That is selected by default
String defaultBranchName = 'All';

//* Pages Navigation Transition Duration
const Duration transitionDuration = Duration(milliseconds: 600);

//* Image Slider Auto Play Interval Duration in milliseconds
const int autoTimeInterval = 40000;

// Key For Fetching Head Quarter
const String headQuarterKey = 'Head Quarter';

// Degree to rad.
double angle({required double angle}) => angle * (pi / 180);

// Font Style Name
const String customFontFamily = 'AmazonBT';

// Post Key
String deliveryManPost = 'Delivery boy';
