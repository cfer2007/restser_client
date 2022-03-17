part of 'order_reservation_bloc.dart';

class OrderReservationState {
  List<DishesOrderReservationModel>? dishesOrderReservationList;
  OrderReservationState({
    this.dishesOrderReservationList,
  });
  OrderReservationState copyWith( {
    List<DishesOrderReservationModel>? dishesOrderReservationList,
  }){
    return OrderReservationState(
      dishesOrderReservationList:  dishesOrderReservationList ?? this.dishesOrderReservationList,     
    );
  }
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