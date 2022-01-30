part of 'reservation_bloc.dart';

class ReservationState {
  ReservationModel? reservation;
  ReservationState({
    this.reservation,
  });
  ReservationState copyWith( {
    ReservationModel? reservation,
  }){
    return ReservationState(
      reservation:  reservation ?? this.reservation,
    );
  }
}

class ReservationInitial extends ReservationState {
  ReservationInitial();
}

class ReservationLoading extends ReservationState {
  ReservationLoading();
}

class ReservationLoaded extends ReservationState {
  final ReservationModel? reservation;
  ReservationLoaded(this.reservation);
}

class ReservationLoadedAll extends ReservationState {
  final ReservationModel? reservation;
  ReservationLoadedAll(this.reservation);
}

class ReservationSetted extends ReservationState {
  final ReservationModel? reservation;
  ReservationSetted(this.reservation);
}

class ReservationConfirmed extends ReservationState {
  ReservationConfirmed();
}

class ReservationError extends ReservationState {
  final String message;
  ReservationError(this.message);
}
