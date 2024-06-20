import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';

part 'all_medicines_event.dart';
part 'all_medicines_state.dart';

class AllMedicinesBloc extends Bloc<AllMedicinesEvent, AllMedicinesState> {
  final ins = FirebaseFirestore.instance;
  AllMedicinesBloc() : super(AllMedicinesInitial()) {
    on<GetAllMedicinesEvent>(getAllMedicines);
    // on<RequestMedicineEvent>(requestMedicine);
  }
  FutureOr<void> getAllMedicines(
      GetAllMedicinesEvent event, Emitter<AllMedicinesState> emit) async {
    try {
      emit(GetAllMedicinesLoadingState());
      final data = await ins.collection('medicines').get();
      List<MedicineModel> result = [];
      if (data.docs.isEmpty) {
        emit(GetAllMedicinesFailureState(message: 'No Medicines yet'));
      } else {
        for (int i = 0; i < data.docs.length; i++) {
          result.add(
              MedicineModel.fromJson(data.docs[i].data(), data.docs[i].id));
        }
        emit(GetAllMedicinesSuccessState(medicines: result));
      }
    } on FirebaseException catch (e) {
      emit(GetAllMedicinesFailureState(message: e.code));
    }
  }

  // FutureOr<void> requestMedicine(RequestMedicineEvent event, Emitter<AllMedicinesState> emit) async{
  //   try{
  //     emit(RequestMedicineLoadingState());
  //     ins.collection('requests').add({
  //       "medicineId":event.medicineId,
  //       "userId":event.userId
  //     });
  //     emit(RequestMedicineSuccessState(message: 'Request Sent successfully'));
  //   }on FirebaseException catch(e){
  //     emit(RequestMedicineFailureState(message: e.code));
  //   }
  // }
}
