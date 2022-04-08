import 'package:restser_client/order/models/order_model.dart';
import 'package:restser_client/reservation/models/reservation_model.dart';
import 'package:restser_client/user/models/user_model.dart';

class CollectAccountModel{
  int? idAccount;
  double? subtotal;
  int? tipPercentage;
  double? tip;
  int? taxPercentage;
  double? tax;  
  double? total;
  UserModel? user;
  ReservationModel? reservation;
  List<OrderModel>? listOrder=[];

  CollectAccountModel({
    this.idAccount,
    this.subtotal,
    this.reservation,
    this.listOrder,
    this.tax,
    this.taxPercentage,
    this.tip,
    this.tipPercentage,
    this.total,
    this.user,
  });

  factory CollectAccountModel.fromJson(Map<String, dynamic> json) {
    var list = json['listOrder'] as List;
    List<OrderModel> lst = list.map((i) => OrderModel.fromJson(i)).toList();
    
    return CollectAccountModel(
      idAccount: json['idAccount'],
      user: UserModel.fromJson(json['user']),
      //reservation: ReservationModel.fromJson(json['reservation']),
      subtotal: json['subtotal'],
      tipPercentage: json['tip_percentage'],
      tip: json['tip'],
      taxPercentage: json['tax_percentage'],
      tax: json['tax'],
      total: json['total'],
      listOrder: lst,
    );
  }
  Map<String, dynamic> toJson() {
    List list = listOrder!.map((e) => e.toJsonConfirm()).toList();
    return {
        "idAccount":idAccount,
        "listOrder": list,
        "total": total,
        "tip":tip,
        "tip_percentage":tipPercentage,
        //"reservation": {"idReservation": reservation!.idReservation},
        //"reservation": reservation,
    };
  }
}