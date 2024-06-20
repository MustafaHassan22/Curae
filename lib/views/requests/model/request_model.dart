import 'package:equatable/equatable.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';

class RequestModel extends Equatable {
  final MedicineModel medicine;
  final UserModel user;
  final String id;
  const RequestModel(
      {required this.medicine, required this.user, required this.id});
  factory RequestModel.fromJson(json, id, requestid) => RequestModel(
      medicine: MedicineModel.fromJson(json['medicine'], id),
      user: UserModel.fromJson(json['user']),
      id: requestid);
  @override
  List<Object?> get props => [medicine, user, id];
}

class UserModel extends Equatable {
  final String id, name, email, phone;
  const UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone});
  factory UserModel.fromJson(json) => UserModel(
      id: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone']);
  @override
  List<Object?> get props => [id, name, email, phone];
}
