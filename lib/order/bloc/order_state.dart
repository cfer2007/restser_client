part of 'order_bloc.dart';

class OrderState {
  List<OrderDishModel>? dishes = [];
  List<OrderModel>? listOrder = [];
  int? count = 0;
  double? total = 0;
  bool? setDishesStatus = false;
  int? idOrder = 0;
  OrderState(
      {this.dishes,
      this.listOrder,
      this.count,
      this.total,
      this.setDishesStatus,
      this.idOrder});

  OrderState copyWith({
    List<OrderDishModel>? dishes,
    int? count,
    double? total,
    bool? setDishesStatus,
    int? idOrder,
  }) {
    return OrderState(
      dishes: dishes ?? this.dishes,
      count: count ?? this.count,
      total: total ?? this.total,
      setDishesStatus: setDishesStatus ?? this.setDishesStatus,
      idOrder: idOrder ?? this.idOrder,
    );
  }
}

class OrderInitial extends OrderState {
  OrderInitial();
}

class OrderListLoading extends OrderState {
  OrderListLoading();
}

class OrderListByClientLoaded extends OrderState {
  final List<OrderModel> listOrder;
  OrderListByClientLoaded(this.listOrder);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}

class OrderDetailError extends OrderState {
  final String message;
  OrderDetailError(this.message);
}
