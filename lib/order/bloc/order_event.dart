part of 'order_bloc.dart';

abstract class OrderEvent {
  const OrderEvent();
}

class AddToOrder extends OrderEvent {
  OrderDishModel? dish;
  AddToOrder({this.dish});
}

class DelFromOrder extends OrderEvent {
  int? index;
  DelFromOrder({this.index});
}

class Increment extends OrderEvent {
  int? index;
  Increment({this.index});
}

class Decrement extends OrderEvent {
  int? index;
  Decrement({this.index});
}

class SetOrder extends OrderEvent {
  OrderModel? order;
  SetOrder({this.order});
}

class GetOrderListByClient extends OrderEvent {
  String? uid;
  GetOrderListByClient({this.uid});
}

class ClearOrderBloc extends OrderEvent {}

class SetOrderError extends OrderEvent {
  String message;
  SetOrderError(this.message);
}
