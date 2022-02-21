class OrderReservationDetailModel{
  int? idOrderReservationDetail;
  String? status;
  String? date;

  OrderReservationDetailModel({
    this.idOrderReservationDetail,
    this.status,
    this.date,
  });

  factory OrderReservationDetailModel.fromJson(Map<String, dynamic> json){
    return OrderReservationDetailModel(
      idOrderReservationDetail: json['idOrderReservationDetail'],
      status: json['status'],
      date: json['date'],
    );
  }
}