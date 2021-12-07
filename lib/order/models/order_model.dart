import '/account/models/account_model.dart';
import '/order/models/order_detail_model.dart';

class OrderModel {
  int? idOrder;
  String? date;
  String? description;
  String? status;
  double? totalPrice;
  int? totalUnits;
  AccountModel? account;
  List<OrderDetailModel>? listOrderDetail;

  OrderModel({
    this.idOrder,
    this.date,
    this.description,
    this.status,
    this.totalPrice,
    this.totalUnits,
    this.account,
    this.listOrderDetail,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var list = json['listOrderDetail'] as List;
    List<OrderDetailModel> listDetail =
        list.map((i) => OrderDetailModel.fromJson(i)).toList();

    return OrderModel(
      idOrder: json['idOrder'],
      date: json['date'],
      description: json['description'],
      status: json['status'],
      totalPrice: json['total_price'],
      totalUnits: json['total_units'],
      account: AccountModel.fromJson(json['account']),
      listOrderDetail: listDetail,
    );
  }
  Map<String, dynamic> toJson() => {
        "date": date,
        "description": description,
        "status": status,
        "total_price": totalPrice,
        "total_units": totalUnits,
        "account": {"idAccount": account!.idAccount},
      };
}
