import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';
import 'package:pharmacy/views/requests/model/request_model.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final ins = FirebaseFirestore.instance;

  RequestBloc() : super(RequestInitial()) {
    on<GetAllRequestsEvent>(getAllRequests);
    on<RequestMedicineEvent>(requestMedicine);
    on<DeleteRequestMedicineEvent>(deleterequestMedicine);
  }
  FutureOr<void> requestMedicine(
      RequestMedicineEvent event, Emitter<RequestState> emit) async {
    try {
      emit(RequestMedicineLoadingState());
      ins
          .collection('requests')
          .add({"medicineId": event.medicineId, "userId": event.userId});
      emit(RequestMedicineSuccessState(message: 'Request Sent successfully'));
    } on FirebaseException catch (e) {
      emit(RequestMedicineFailureState(message: e.code));
    }
  }

  FutureOr<void> deleterequestMedicine(
      DeleteRequestMedicineEvent event, Emitter<RequestState> emit) async {
    try {
      ins.collection('requests').doc(event.requestid).delete();
      // emit(RequestMedicineSuccessState(message: 'Request Sent successfully'));
    } on FirebaseException catch (e) {}
  }

  FutureOr<void> getAllRequests(
      GetAllRequestsEvent event, Emitter<RequestState> emit) async {
    try {
      emit(GetAllRequestsLoadingState());
      final requests = await ins.collection('requests').get();
      List<RequestModel> request = [];
      for (int i = 0; i < requests.docs.length; i++) {
        final user = await getUser(requests.docs[i].data()['userId']);
        final medicine =
            await getMedicine(requests.docs[i].data()['medicineId']);
        request.add(RequestModel(
            medicine: medicine, user: user, id: requests.docs[i].id));
      }
      emit(GetAllRequestsSuccessState(requests: request));
    } on FirebaseException catch (e) {
      emit(GetAllRequestsFailureState(message: e.code));
    }
  }

  FutureOr<MedicineModel> getMedicine(String medicineId) async {
    final data = await ins.collection('medicines').doc(medicineId).get();
    return MedicineModel.fromJson(data.data(), medicineId);
  }

  FutureOr<UserModel> getUser(String userId) async {
    final data =
        await ins.collection('Users').where('uid', isEqualTo: userId).get();
    return UserModel.fromJson(data.docs[0].data());
  }
}
