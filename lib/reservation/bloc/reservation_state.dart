part of 'reservation_bloc.dart';

class ReservationState {
  ReservationModel? reservation;  
  List<ReservationFinishModel>? reservationFinishedList;
  ReservationActiveModel? reservationOrdersActive;

  ReservationState({
    this.reservation,
    this.reservationFinishedList,
    this.reservationOrdersActive,
  });
  ReservationState copyWith( {
    ReservationModel? reservation,  
    List<ReservationFinishModel>? reservationFinishedList,  
    ReservationActiveModel? reservationOrdersActive,
  }){
    return ReservationState(
      reservation:  reservation ?? this.reservation,
      reservationFinishedList: reservationFinishedList?? this.reservationFinishedList,
      reservationOrdersActive: reservationOrdersActive?? this.reservationOrdersActive,
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

class ReservationFinishedListLoaded extends ReservationState {
  final List<ReservationFinishModel>? reservationFinishedList;
  ReservationFinishedListLoaded(this.reservationFinishedList);
}

class ReservationOrdersActiveLoaded extends ReservationState {
  final ReservationActiveModel? reservationOrdersActive;
  ReservationOrdersActiveLoaded(this.reservationOrdersActive);
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
