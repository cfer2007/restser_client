part of 'order_reservation_bloc.dart';

class OrderReservationState {
  /*List<OrderReservationModel>? orderReservationList;
  OrderReservationState({
    this.orderReservationList,
  });
  OrderReservationState copyWith( {
    OrderReservationModel? orderReservationList,    
  }){
    return OrderReservationState(
      orderReservationList:  orderReservationList ?? this.orderReservationList,     
    );
  }*/
}

class OrderReservationInitial extends OrderReservationState {}

class OrderReservationListLoaded extends OrderReservationState {
  List<DishesOrderReservationModel>? dishesOrderReservationList;
  OrderReservationListLoaded(this.dishesOrderReservationList);
}

class OrderReservationError extends OrderReservationState {
  final String message;
  OrderReservationError(this.message);
}