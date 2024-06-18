import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import 'package:pharmacy/views/add_medicine/bloc/add_medicine_bloc.dart';
import 'package:pharmacy/views/all_medicines/bloc/all_medicines_bloc.dart';
import 'package:pharmacy/views/auth/widget/button.dart';

import '../auth/widget/text_field.dart';

class AddMedicineScreens extends StatefulWidget {
  const AddMedicineScreens({super.key});

  @override
  State<AddMedicineScreens> createState() => _AddMedicineScreensState();
}

class _AddMedicineScreensState extends State<AddMedicineScreens> {
  final bloc = KiwiContainer().resolve<AddMedicineBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF4E97C5).withOpacity(0.6),
        title: const Text('Add Medicine',
            style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.w700,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Form(
          key: bloc.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Color(0xFF4E97C5), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.15),
                      )
                    ]),
                child: InkWell(
                  onTap: () {
                    bloc.pickImage.imagePickerDialog(
                      context: context,
                      onSubmit: (file, name) {
                        setState(() {
                          bloc.imageFile = file;
                          bloc.imageName = name;
                        });
                      },
                    );
                  },
                  child: bloc.imageFile == null
                      ? Center(
                          child: Image.asset(
                          Assets.images.addImage.path,
                          fit: BoxFit.cover,
                          color: Color(0xFF4E97C5),
                          height: 130,
                          width: 130,
                        ))
                      : Center(
                          child:
                              Image.file(bloc.imageFile!, fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              textField(
                context,
                'Name',
                bloc.name,
                (value) {
                  if (value == '') {
                    return 'please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              textField(
                context,
                'Medicine Name',
                bloc.description,
                (value) {
                  if (value == '') {
                    return 'please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              textField(
                context,
                'Your Number',
                bloc.price,
                (value) {
                  if (value == '') {
                    return 'please enter your number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              textField(
                context,
                'Your Location',
                bloc.location,
                (value) {
                  if (value == '') {
                    return 'please enter location';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 25.h,
              ),
              BlocListener(
                bloc: bloc,
                listener: (context, state) {
                  if (state is AddMedicineSuccessState) {
                    toast(msg: state.message);
                    setState(() {
                      bloc.imageFile = null;
                      bloc.name.clear();
                      bloc.price.clear();
                      bloc.description.clear();
                      bloc.location.clear();
                    });
                    KiwiContainer()
                        .resolve<AllMedicinesBloc>()
                        .add(GetAllMedicinesEvent());
                  }
                },
                child: SizedBox(
                  width: 343.w,
                  height: 50.h,
                  child: buttonWidget(
                      onTap: () {
                        if (bloc.formKey.currentState!.validate()) {
                          if (bloc.imageFile == null) {
                            toast(msg: 'choose image');
                          } else {
                            bloc.add(AddMedicineNowEvent(
                              name: bloc.name.text,
                              price: bloc.price.text,
                              description: bloc.description.text,
                              image: bloc.imageFile!,
                              imageName: bloc.imageName,
                              location: bloc.location.text,
                            ));
                          }
                        }
                      },
                      text: 'Save',
                      fontSize: 18.sp,
                      radius: 15.0.r),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
