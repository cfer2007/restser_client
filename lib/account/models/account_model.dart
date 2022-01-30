import 'package:restser_client/order/models/order_model.dart';

import '/user/models/user_model.dart';
import '/reservation/models/reservation_model.dart';

class AccountModel {
  int? idAccount;
  double? subtotal;
  UserModel? user;
  ReservationModel? reservation;
  List<OrderModel>? listOrder=[];

  AccountModel({
    this.idAccount,
    this.subtotal,
    required this.user,
    this.reservation,
    this.listOrder,
  });
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    var list = json['listOrder'] as List;
    List<OrderModel> lst = list.map((i) => OrderModel.fromJson(i)).toList();
    
    return AccountModel(
      idAccount: json['idAccount'],
      user: UserModel.fromJson(json['user']),
      subtotal: json['subtotal'],
      listOrder: lst,
    );
  }
  Map<String, dynamic> toJson() => {
        "user": {"uid": user!.uid},
        "reservation": {"idReservation": reservation!.idReservation},
  };
  Map<String, dynamic> toJsonConfirm() {
    List list = listOrder!.map((e) => e.toJsonConfirm()).toList();
    return {
        "idAccount":idAccount,
        "user": user,
        "listOrder": list,
        "subtotal": subtotal,
    };
  }
}
