import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/core/helper_methods.dart';
import 'package:pharmacy/views/add_medicine/add_medicine.dart';
import 'package:pharmacy/views/all_medicines/all_medicines.dart';
import 'package:pharmacy/views/auth/login/bloc/login_bloc.dart';
import 'package:pharmacy/views/auth/signup/signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/wrapper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = KiwiContainer().resolve<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 250, 255),
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Form(
            key: bloc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Image.asset(
                  'assets/images/log.png',
                  height: 200,
                ),
                Text(
                  'Login',
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextFormField(
                  controller: bloc.email,
                  validator: (value) {
                    if (value == '') {
                      return 'please enter email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15.r))),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: bloc.password,
                  obscureText: true,
                  validator: (value) {
                    if (value == '') {
                      return 'please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r))),
                ),
                SizedBox(
                  height: 16.h,
                ),
                BlocListener(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      toast(msg: state.message);
                      navigateTo(context, page: Wrapper(), withHistory: false);
                    } else if (state is LoginFailureState) {
                      toast(msg: state.message);
                    }
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        if (bloc.formKey.currentState!.validate()) {
                          bloc.add(LoginNowEvent(
                              email: bloc.email.text,
                              password: bloc.password.text));
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.blue),
                      )),
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
                        text: 'Don\'t have Account',
                        style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                    TextSpan(
                        text: ' Sign up',
                        style: TextStyle(color: Colors.blue, fontSize: 16.sp)),
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
