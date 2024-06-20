import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/views/auth/widget/button.dart';
import 'package:pharmacy/views/requests/model/request_model.dart';
import 'package:skeletons/skeletons.dart';

class RequestCard extends StatelessWidget {
  final RequestModel request;
  final VoidCallback func;
  const RequestCard({super.key, required this.request, required this.func});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h, // Increase height to prevent overflow
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(16.r),
        boxShadow: const [
          BoxShadow(color: Color(0x406b6b6b), spreadRadius: 1, blurRadius: 5),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildImage(),
          SizedBox(width: 20.w),
          Expanded(child: buildDetailsColumn()),
        ],
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

  Widget buildDetailsColumn() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Adjusted mainAxisAlignment
        children: [
          buildText(
            request.medicine.name,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
          buildText(
            request.medicine.description,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.black45,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          buildText(
            '${request.medicine.price}',
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.black45,
          ),
          buildText('Ordered by : ${request.user.name}',
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              color: Colors.black45),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 100.w,
              height: 30.h,
              child: buttonWidget(onTap: func, text: 'confirm'),
            ),
          ),
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
