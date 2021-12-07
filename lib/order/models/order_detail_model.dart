//import '/order/models/order_model.dart';

class OrderDetailModel {
  int? idOrderDetail;
  int? idDish;
  int? idOrder;
  String? name;
  String? currency;
  double? price;
  int? units;

  OrderDetailModel({
    this.idOrderDetail,
    this.idDish,
    this.idOrder,
    this.name,
    this.currency,
    this.price,
    this.units,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      idOrderDetail: json['idOrderDetail'],
      idDish: json['idDish'],
      //order: OrderModel.fromJson(json['idOrder']),
      name: json['name'],
      currency: json['currency'],
      price: json['price'],
      units: json['units'],
    );
  }
  Map<String, dynamic> toJson() => {
        "idDish": idDish,
        "order": {"idOrder": idOrder},
        "name": name,
        "currency": currency,
        "price": price,
        "units": units,
      };
}
