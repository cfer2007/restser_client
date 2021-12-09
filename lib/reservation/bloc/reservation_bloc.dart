import 'dart:async';

//import '/account/models/account_model.dart';
import '/reservation/models/reservation_model.dart';
import '/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ApiRepository _apiRepository = ApiRepository();
  ReservationBloc() : super(ReservationInitial());

  @override
  Stream<ReservationState> mapEventToState(
    ReservationEvent event,
  ) async* {
    try {
      if (event is ClearReservationBloc) yield ReservationInitial();
      if (event is SetReservation) {
        print('setReservation');
        yield ReservationLoading();
        final res = await _apiRepository.setReservation(event.reservation);
        if (res.error) {
          yield ReservationError(res.errorMessage as String);
        } else {
          yield ReservationSetted(res.data as ReservationModel);
          //yield ReservationLoaded(res.data as ReservationModel, true);
        }
      }
      if (event is GetReservation) {
        yield ReservationLoading();
        final res = await _apiRepository.getReservation(event.idReservation);
        if (res.error) {
          yield ReservationError(res.errorMessage as String);
        } else {
          yield ReservationLoaded(res.data as ReservationModel /*, false*/);
        }
      }
    } on NetworkError {
      yield ReservationError("Failed to fetch data. is your device online?");
    }
  }
}
