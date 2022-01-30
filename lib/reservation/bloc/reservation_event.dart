part of 'reservation_bloc.dart';

abstract class ReservationEvent {
  const ReservationEvent();
}

class SetReservation extends ReservationEvent {
  final ReservationModel reservation;
  SetReservation(this.reservation);
}

class GetReservation extends ReservationEvent {
  final String idReservation;
  GetReservation(this.idReservation);
}
class GetReservationAll extends ReservationEvent {
  final int idReservation;
  GetReservationAll(this.idReservation);
}

class GetOrderListByReservation extends ReservationEvent {
  int? idReservation;
  GetOrderListByReservation({this.idReservation});
}

class ConfirmReservation extends ReservationEvent {
  final ReservationModel reservation;
  ConfirmReservation(this.reservation);
}

class Increment extends ReservationEvent{
  int indexAccount;
  int indexOrder;
  int indexDish;
  Increment({required this.indexAccount, required this.indexOrder, required this.indexDish});
}

class Decrement extends ReservationEvent{
  int indexAccount;
  int indexOrder;
  int indexDish;
  Decrement({required this.indexAccount, required this.indexOrder, required this.indexDish});
}

class ClearReservationBloc extends ReservationEvent {}
