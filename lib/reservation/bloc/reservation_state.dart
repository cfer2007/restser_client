part of 'reservation_bloc.dart';

class ReservationState {
//  final ReservationModel? reservation;
  //final bool? isNew;
  ReservationState(/*{this.reservation  , this.isNew}*/);
}

class ReservationInitial extends ReservationState {
  ReservationInitial();
}

class ReservationLoading extends ReservationState {
  ReservationLoading();
}

class ReservationLoaded extends ReservationState {
  final ReservationModel reservation;
  //final bool isNew;
  ReservationLoaded(this.reservation /*, this.isNew*/);
}

class ReservationSetted extends ReservationState {
  final ReservationModel reservation;
  //final bool isNew;
  ReservationSetted(this.reservation /*, this.isNew*/);
}

class ReservationError extends ReservationState {
  final String message;
  ReservationError(this.message);
}
