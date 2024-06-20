part of 'add_medicine_bloc.dart';

sealed class AddMedicineState {}

final class AddMedicineInitial extends AddMedicineState {}

final class DeleteMedicineInitial extends AddMedicineState {}

final class AddMedicineLoadingState extends AddMedicineState {}

final class AddMedicineSuccessState extends AddMedicineState {
  final String message;
  AddMedicineSuccessState({required this.message});
}

final class AddMedicineFailureState extends AddMedicineState {
  final String message;
  AddMedicineFailureState({required this.message});
}
