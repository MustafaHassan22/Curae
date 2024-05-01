import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:pharmacy/views/auth/login/bloc/login_bloc.dart';
import 'package:pharmacy/views/auth/signup/bloc/signup_bloc.dart';


Future<void> initKiwi() async {
  KiwiContainer container = KiwiContainer();
  container.registerFactory((container) => LoginBloc());
  container.registerFactory((container) => SignupBloc());


}
