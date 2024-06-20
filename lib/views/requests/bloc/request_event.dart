part of 'request_bloc.dart';

abstract class RequestEvent extends Equatable {}

class GetAllRequestsEvent extends RequestEvent {
  @override
  List<Object?> get props => [];
}

class RequestMedicineEvent extends RequestEvent {
  final String medicineId, userId;
  RequestMedicineEvent({required this.medicineId, required this.userId});
  @override
  List<Object?> get props => [medicineId, userId];
}

class DeleteRequestMedicineEvent extends RequestEvent {
  final String requestid;
  DeleteRequestMedicineEvent({
    required this.requestid,
  });
  @override
  List<Object?> get props => [requestid];
}
