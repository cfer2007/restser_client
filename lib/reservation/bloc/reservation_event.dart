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

class ClearReservationBloc extends ReservationEvent {}
