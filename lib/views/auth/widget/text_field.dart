import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextFormField textField({String? hintText,TextEditingController? controller,String? Function(String?)? validator,Widget? prefixIcon}){
   return TextFormField(
    controller: controller,
    validator:validator,
    decoration: InputDecoration(
      hintText: hintText,
        prefixIcon:prefixIcon ,
        prefixIconColor: Color(0xFF4DA8CF),
        hintStyle: TextStyle(
          color: Colors.black38,
        ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Color(0xFF4DA8CF),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Color(0xFF4DA8CF),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Color(0xFF4DA8CF),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15.r),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}