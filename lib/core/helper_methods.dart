import 'package:flutter/material.dart';

Future navigateTo(context, {required Widget page, bool withHistory = true}) {
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => withHistory);
}

Future navigateAndReplace(context, {required Widget page}) {
  return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ));
}
// PreferredSizeWidget? customAppBar(String name,context, {VoidCallback? onTap,bool isCustom=false,Widget? widget}){
//   String dir = CacheHelper.getLang() == 'en' ? 'left.png' : 'right.png';
//   return AppBar(
//     automaticallyImplyLeading: false,
//     backgroundColor: Colors.transparent,
//     shape: const OutlineInputBorder(borderSide: BorderSide.none),
//     elevation: 0,
//     centerTitle: true,
//     title: Text(
//       name,
//       style: const TextStyle(color: colorPrimary),
//     ),
//     leading: IconButton(
//       onPressed:isCustom?onTap:() {
//         Navigator.pop(context);
//       },
//       icon: Container(
//         decoration: BoxDecoration(
//           color: greyBackground,
//           borderRadius: BorderRadiusDirectional.all(Radius.circular(9.r)),
//         ),
//         width: 32.w,
//         height: 32.h,
//         child: Image.asset(
//           'assets/icons/$dir',
//           color: colorPrimary,
//         ),
//       ),
//     ),
//     actions: [widget??const SizedBox()],
//   );
// }