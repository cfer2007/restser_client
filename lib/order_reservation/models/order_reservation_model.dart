import 'package:restser_client/order_reservation/models/order_reservation_detail_model.dart';

class OrderReservationModel {
  int? idOrderReservation;
  int? idReservation;
  String? status;
  String? date;
  List<OrderReservationDetailModel>? listOrderReservationDetail;

  OrderReservationModel({
    this.idOrderReservation,
    this.idReservation,
    this.status,
    this.date,
    this.listOrderReservationDetail,
  });
  factory OrderReservationModel.fromJson(Map<String, dynamic> json) {
    var list = json['listOrderReservation'] as List;
    List<OrderReservationDetailModel> listOR =
        list.map((i) => OrderReservationDetailModel.fromJson(i)).toList();

    return OrderReservationModel(
      idOrderReservation: json['idOrderReservation'],
      idReservation: json['idReservation'],
      status: json['status'],
      date: json['date'],
      listOrderReservationDetail: listOR,
    );
  }
}
