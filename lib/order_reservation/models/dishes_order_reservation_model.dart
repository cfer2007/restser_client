import 'package:restser_client/order/models/order_dish_model.dart';
import 'package:restser_client/order_reservation/models/order_reservation_model.dart';

class DishesOrderReservationModel{
  OrderReservationModel? orderReservation;
  List<OrderDishModel>? orderDishList;

  DishesOrderReservationModel({
    this.orderReservation,
    this.orderDishList,
  });
  factory DishesOrderReservationModel.fromJson(Map<String, dynamic> json) {
    var list = json['orderDishList'] as List;
    List<OrderDishModel> listOrderDish =
        list.map((i) => OrderDishModel.fromJsonOrderReservation(i)).toList();
    return DishesOrderReservationModel(
      orderReservation: OrderReservationModel.fromJson(json["orderReservation"]),
      orderDishList: listOrderDish,
    );
  }
}