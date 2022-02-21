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

class GetReservationFinishedList extends ReservationEvent {
  final String uid;
  GetReservationFinishedList(this.uid);
}

class GetActiveReservation extends ReservationEvent{
  final String uid;
  GetActiveReservation(this.uid);
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
