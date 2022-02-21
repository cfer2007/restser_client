part of 'order_reservation_bloc.dart';

abstract class OrderReservationEvent {
  const OrderReservationEvent();
}

class GetOrderReservationList extends OrderReservationEvent {
  String? uid;
  GetOrderReservationList(this.uid);
}