import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';
import 'package:skeletons/skeletons.dart';

class MedicineCard extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onTap;
  const MedicineCard({super.key, required this.medicine,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 150.h,
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(16.r),
          boxShadow: const [
            BoxShadow(color: Color(0x406b6b6b), spreadRadius: 1, blurRadius: 5)
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
              width: 120.w,
              child: ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(16.r),
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      width: double.infinity,
                      //   height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                    imageUrl: medicine.image,
                    placeholder: (context, url) => SkeletonAvatar(
                      style: SkeletonAvatarStyle(width: 120.w),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ))),
          SizedBox(
            width: 20.w,
          ),
          SizedBox(
            width: 190.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      medicine.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                    Spacer(),
                    Text('${medicine.price} \$',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.blue))
                  ],
                ),
                Text(
                  medicine.description,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp,
                      color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: SizedBox(
                    width: 100.w,
                      height: 30.h,
                      child: ElevatedButton(
                          onPressed: onTap, child: Text('Request'))),
                )
                // Align(alignment:AlignmentDirectional.bottomEnd,child: ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
