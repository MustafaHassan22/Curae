import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';
import 'package:pharmacy/views/requests/model/request_model.dart';
import 'package:skeletons/skeletons.dart';

class RequestCard extends StatelessWidget {
  final RequestModel request;
  const RequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 180.h,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF4E97C5).withOpacity(0.4),
          borderRadius: BorderRadiusDirectional.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildImage(),
            SizedBox(width: 20.w),
            Expanded(child: buildDetailsColumn()),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return SizedBox(
      width: 120.w,
      height: 140.h,
      child: ClipRRect(
        borderRadius: BorderRadiusDirectional.circular(16.r),
        child: CachedNetworkImage(
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
            ),
          ),
          imageUrl: request.medicine.image,
          placeholder: (context, url) => SkeletonAvatar(
            style: SkeletonAvatarStyle(width: 120.w),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Padding buildDetailsColumn() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildText(
            request.medicine.name,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
          SizedBox(
            height: 5,
          ),
          buildText(
            request.medicine.description,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.black45,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          SizedBox(
            height: 3,
          ),
          buildText(
            'Phone : ${request.medicine.price}',
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.black45,
          ),
          SizedBox(
            height: 5,
          ),
          buildText('Ordered by : ${request.user.name}',
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              color: Colors.black45),
        ],
      ),
    );
  }

  Widget buildText(
    String text, {
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 14.0,
    Color color = Colors.black,
    TextOverflow overflow = TextOverflow.visible,
    int maxLines = 1,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
