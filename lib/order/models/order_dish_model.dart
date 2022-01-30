//import '/order/models/order_model.dart';

class OrderDishModel {
  int? idOrderDish;
  int? idDish;
  int? idOrder;
  String? name;
  String? currency;
  double? price;
  int? units;

  OrderDishModel({
    this.idOrderDish,
    this.idDish,
    this.idOrder,
    this.name,
    this.currency,
    this.price,
    this.units,
  });

  factory OrderDishModel.fromJson(Map<String, dynamic> json) {
    return OrderDishModel(
      idOrderDish: json['idOrderDish'],
      idDish: json['idDish'],
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
  Map<String, dynamic> toJsonConfirm() => {
        "idDish": idDish,
        "idOrderDish": idOrderDish,
        "name": name,
        "currency": currency,
        "price": price,
        "units": units,
      };
}
