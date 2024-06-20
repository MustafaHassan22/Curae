import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/views/add_medicine/add_medicine.dart';
import 'package:pharmacy/views/all_medicines/all_medicines.dart';
import 'package:pharmacy/views/auth/login/bloc/login_bloc.dart';
import 'package:pharmacy/views/auth/signup/signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/views/auth/widget/text_field.dart';
import 'package:pharmacy/wrapper.dart';

import '../../../gen/assets.gen.dart';
import '../widget/button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = KiwiContainer().resolve<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4DA8CF),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 150.h,
                ),
                Text(
                  'Welcome Back..',
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'courgette',
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),

                // SizedBox(
                //     height: 300.h > 300 ? 300.h : 300,
                //     width: double.infinity,
                //     child: Image.asset(
                //       'assets/images/login.jpg',
                //       fit: BoxFit.fill,
                //     )),
                Form(
                  key: bloc.formKey,
                  child: SizedBox(
                    child: Container(
                      height: 625.h,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 244, 250, 255),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   widthFactor: 4.5,
                          //   child: Text(
                          //     'Login',
                          //     style: TextStyle(
                          //         fontSize: 30.sp,
                          //         fontWeight: FontWeight.bold,
                          //         color: Color(0xFF4DA8CF)),
                          //   ),
                          // ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: textField(
                              hintText: 'Email',
                              prefixIcon: const Icon(Icons.email),
                              controller: bloc.email,
                              validator: (value) {
                                if (value == '') {
                                  return 'please enter email address';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: textField(
                              obscureText: true,
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              controller: bloc.password,
                              validator: (value) {
                                if (value == '') {
                                  return 'please enter password';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          BlocListener(
                            bloc: bloc,
                            listener: (context, state) {
                              if (state is LoginSuccessState) {
                                // toast(msg: state.message);
                                navigateTo(context,
                                    page: Wrapper(), withHistory: false);
                              } else if (state is LoginFailureState) {}
                            },
                            child: SizedBox(
                              width: 343.w,
                              height: 50.h,
                              child: buttonWidget(
                                onTap: () {
                                  if (bloc.formKey.currentState!.validate()) {
                                    bloc.add(LoginNowEvent(
                                        email: bloc.email.text,
                                        password: bloc.password.text));
                                  }
                                },
                                text: 'Login',
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
                              navigateTo(context, page: SignUpScreen());
                            },
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Don\'t have Account ? ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.sp)),
                              TextSpan(
                                  text: ' Sign up',
                                  style: TextStyle(
                                      color: const Color(0xFF4DA8CF),
                                      fontSize: 16.sp)),
                            ])),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
