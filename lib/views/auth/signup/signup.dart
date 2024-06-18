import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/views/all_medicines/all_medicines.dart';
import 'package:pharmacy/views/auth/signup/bloc/signup_bloc.dart';
import 'package:pharmacy/views/auth/widget/button.dart';
import 'package:pharmacy/views/auth/widget/text_field.dart';
import 'package:pharmacy/wrapper.dart';

class SignUpScreen extends StatelessWidget {
  final bloc = KiwiContainer().resolve<SignupBloc>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 250, 255),
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Form(
            key: bloc.formKey,
            child: Column(
              children: [
                // SizedBox(
                //   height: 50.h,
                // ),
                Image.asset(
                  'assets/images/log.png',
                  height: 100,
                ),
=======
    return  Scaffold(
      backgroundColor: const Color(0xFF4DA8CF),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
        child: Form(
          key: bloc.formKey,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [

                Spacer(flex: 2,),
>>>>>>> 38299405aab368abde625a174d20d6ef6f107712
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                Spacer(),
                Container(
                  height: 580.h,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 250, 255),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      textField(
                        hintText: 'Name',
                        controller: bloc.name,
                        validator: (value) {
                          if (value == '') {
                            return 'please enter your name';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.person),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      textField(
                        hintText: 'Phone Number',
                        controller: bloc.phone,
                        validator: (value) {
                          if (value == '') {
                            return 'please enter your phone number';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.phone),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      textField(
                        hintText: 'Email',
                        controller: bloc.email,
                        validator: (value) {
                          if (value == '') {
                            return 'please enter your email';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.email),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      textField(
                        hintText: 'Password',
                        controller: bloc.password,
                        validator: (value) {
                          if (value == '') {
                            return 'please enter your password';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.lock),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      textField(
                        hintText: 'Confirm Password',
                        controller: bloc.confirmPassword,
                        validator: (value) {
                          if (value == '') {
                            return 'please enter your password';
                          } else if (bloc.password.text != value) {
                            return 'passwords do not match';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.lock),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      BlocListener(
                        bloc: bloc,
                        listener: (context, state) {
                          if (state is SignupSuccessState) {
                            toast(msg: state.message);
                            navigateTo(context, page: Wrapper(), withHistory: false);
                          } else if (state is SignupFailureState) {
                            toast(msg: state.message);
                          }
                        },
                        child: SizedBox(
                          width: 343.w,
                          height: 50.h,
                          child: buttonWidget(
                            onTap: () {
                              if (bloc.formKey.currentState!.validate()) {
                                bloc.add(SignupNowEvent(
                                  name: bloc.name.text.trim(),
                                  email: bloc.email.text.trim(),
                                  password: bloc.password.text,
                                  phone: bloc.phone.text.trim(),
                                ));
                              }
                            },
                            text: 'Sign Up',
                            fontSize: 18.sp,
                            radius: 15.0.r,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Have Account ? ',
                                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                              ),
                              TextSpan(
                                text: ' Login',
                                style: TextStyle(color: Color(0xFF4DA8CF), fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
