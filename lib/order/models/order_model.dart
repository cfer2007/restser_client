import '/account/models/account_model.dart';
import 'order_dish_model.dart';

class OrderModel {
  int? idOrder;
  String? date;
  String? description;
  //String? status;
  String? currency;
  double? totalPrice;
  int? totalUnits;
  AccountModel? account;
  List<OrderDishModel>? listOrderDish;

  OrderModel({
    this.idOrder,
    this.date,
    this.description,
    //this.status,
    this.currency,
    this.totalPrice,
    this.totalUnits,
    this.account,
    this.listOrderDish,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var list = json['listOrderDish'] as List;
    List<OrderDishModel>? listDetail = list.map((i) => OrderDishModel.fromJson(i)).toList();

    return OrderModel(
      idOrder: json['idOrder'],
      date: json['date'],
      description: json['description'],
      //status: json['status'],
      totalPrice: json['total_price'],
      totalUnits: json['total_units'],
      currency: json['currency'],
      //account: AccountModel.fromJson(json['account']),
      listOrderDish: listDetail,
    );
  }
  Map<String, dynamic> toJson() => {
        "date": date,
        "description": description,
        //"status": status,
        "total_price": totalPrice,
        "total_units": totalUnits,
        "account": {"idAccount": account!.idAccount},
        "currency": currency,
      };
  Map<String, dynamic> toJsonConfirm() {
    List list = listOrderDish!.map((e) => e.toJsonConfirm()).toList(); 
    return{
        "idOrder": idOrder,
        "date": date,
        "description": description,
        //"status": status,
        "total_price": totalPrice,
        "total_units": totalUnits,
        "listOrderDish":list,
        
      };
    }
}
