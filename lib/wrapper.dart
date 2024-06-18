import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/views/add_medicine/add_medicine.dart';
import 'package:pharmacy/views/all_medicines/all_medicines.dart';
import 'package:pharmacy/views/requests/requests.dart';

class Wrapper extends StatefulWidget {
  Wrapper({super.key,this.currentIndex=0});
  int currentIndex ;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final titles=['Medicines','Add','Requests'];

  final List<String> icons=[Assets.icons.medicine,Assets.icons.add,Assets.icons.requests];

  final List<Widget>screens=[AllMedicinesScreen(),AddMedicineScreens(),RequestsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,

        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        selectedLabelStyle: const TextStyle(color: Color(0xFF4DA8CF)),

        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        unselectedItemColor: Color(0xFF4DA8CF).withOpacity(0.5),
        fixedColor:  Color(0xFF4DA8CF),
        items: List.generate(icons.length, (index) => BottomNavigationBarItem(icon: SvgPicture.asset(icons[index],width: 30.w,height: 30.h,color:Color(0xFF4DA8CF) ,),label: titles[index])),
        currentIndex: widget.currentIndex,
        onTap: (value) {
          setState(() {
            widget.currentIndex=value;
          });
        },
      ),
      body: screens[widget.currentIndex],
    );
  }
}
