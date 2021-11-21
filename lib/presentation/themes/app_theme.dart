import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData themeData() {
  return ThemeData(
      primaryColor: mainAppColor,
      hintColor: hintColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xffFFFFFF),
      fontFamily: GoogleFonts.tajawal().fontFamily,
      textTheme: TextTheme(
        headline1: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        headline2: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w800),
        button: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.sp),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: mainAppColor));
}
