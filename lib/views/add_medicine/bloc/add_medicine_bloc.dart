import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/core/image_picker.dart';

part 'add_medicine_event.dart';
part 'add_medicine_state.dart';

class AddMedicineBloc extends Bloc<AddMedicineEvent, AddMedicineState> {
  final name = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  final location = TextEditingController();
  String imageName = "";
  PickImage pickImage = PickImage.init;
  File? imageFile;
  final imageIns = FirebaseStorage.instance.ref();
  final ins = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();

  AddMedicineBloc() : super(AddMedicineInitial()) {
    on<AddMedicineNowEvent>(addMedicine);
    on<DeletemedicineEvent>(deleteMedicine);
  }
  FutureOr<void> addMedicine(
      AddMedicineNowEvent event, Emitter<AddMedicineState> emit) async {
    try {
      emit(AddMedicineLoadingState());
      final imageRef = imageIns.child('${DateTime.now()} ${event.imageName}');
      await imageRef.putFile(event.image);
      final storageRef = await imageRef.getDownloadURL();
      ins.collection('medicines').add({
        'name': event.name,
        'price': event.price,
        'description': event.description,
        'location': location.text,
        'image': storageRef,
        'createdAt': DateTime.now().toIso8601String(),
      });
      emit(AddMedicineSuccessState(message: 'medicine added successfully'));
    } on FirebaseException catch (e) {
      emit(AddMedicineFailureState(message: e.code));
    }
  }

  FutureOr<void> deleteMedicine(
      DeletemedicineEvent event, Emitter<AddMedicineState> emit) async {
    try {
      ins.collection('medicines').doc(event.id);
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}
