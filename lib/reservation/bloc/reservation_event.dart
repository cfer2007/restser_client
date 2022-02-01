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
  final String idReservation;
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

class IncrementUnits extends ReservationEvent{
  int indexAccount;
  int indexOrder;
  int indexDish;
  IncrementUnits({required this.indexAccount, required this.indexOrder, required this.indexDish});
}

class DecrementUnits extends ReservationEvent{
  int indexAccount;
  int indexOrder;
  int indexDish;
  DecrementUnits({required this.indexAccount, required this.indexOrder, required this.indexDish});
}

class ClearReservationBloc extends ReservationEvent {}
