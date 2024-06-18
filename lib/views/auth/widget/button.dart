

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ElevatedButton buttonWidget({required VoidCallback onTap,
  double? fontSize,required String text, double? radius}){
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF4DA8CF),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ??8.r),
      ),
    ),
    child: Text(text,
        style: TextStyle( fontSize: fontSize??14.sp,color: Colors.white)),
  );
}