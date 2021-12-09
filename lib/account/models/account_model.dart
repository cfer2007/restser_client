import '/user/models/user_model.dart';
import '/reservation/models/reservation_model.dart';

class AccountModel {
  int? idAccount;
  UserModel? user;
  ReservationModel? reservation;

  AccountModel({
    this.idAccount,
    required this.user,
    required this.reservation,
  });
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      idAccount: json['idAccount'],
      user: UserModel.fromJson(json['user']),
      reservation: ReservationModel.fromJson(json['reservation']),
    );
  }
  Map<String, dynamic> toJson() => {
        "user": {"uid": user!.uid},
        "reservation": {"idReservation": reservation!.idReservation},
      };
}
