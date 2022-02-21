class ReservationFinishModel{
  int? idReservation;
  String? start;
  String? finish;
  String? currency;
  double? subtotal;

  ReservationFinishModel({
    this.idReservation,
    this.start,
    this.finish,
    this.currency,
    this.subtotal,
  });

  factory ReservationFinishModel.fromJson(Map<String, dynamic> json) => 
    ReservationFinishModel(
      idReservation: json['idReservation'],
      start: json['start'],
      finish: json['finish'],
      currency: json['currency'],
      subtotal: json['subtotal'],
    );
}