import 'dart:async';
import 'package:restser_client/reservation/models/reservation_finish_model.dart';
import 'package:restser_client/reservation/models/reservation_active_model.dart';

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
      if (event is ClearReservationBloc){ 
        //yield ReservationInitial();
      }
      if (event is SetReservation) {    
        yield ReservationLoading();
        final res = await _apiRepository.setReservation(event.reservation);        
        if (res.error) {
          yield ReservationError(res.errorMessage as String);
        } else {
          state.copyWith(reservation: res.data as ReservationModel);
          yield ReservationSetted(res.data as ReservationModel);          
        }
      }
      if (event is GetReservation) {
        yield ReservationLoading();
        final res = await _apiRepository.getReservation(event.idReservation);
        if (res.error) {
          yield ReservationError(res.errorMessage as String);
        } else {
          state.copyWith(reservation: res.data as ReservationModel);
          yield ReservationLoaded(res.data as ReservationModel);
        }
      }

      if (event is GetReservationFinishedList) {
        yield ReservationLoading();
        final res = await _apiRepository.getFinishReservationList(event.uid);
        if (res.error) {
          yield ReservationError(res.errorMessage as String);
        } else {
          state.copyWith(reservationFinishedList: res.data as List<ReservationFinishModel>);
          yield ReservationFinishedListLoaded(res.data as List<ReservationFinishModel>);
        }
      }

      if (event is GetActiveReservation) {
        yield ReservationLoading();
        final res = await _apiRepository.getOrdersActiveByReservation(event.uid);
        if (res.error) {
          yield ReservationError(res.errorMessage as String);
        } else {
          state.copyWith(reservationOrdersActive: res.data as ReservationActiveModel);
          yield ReservationOrdersActiveLoaded(res.data as ReservationActiveModel);
        }
      }

      if(event is ConfirmReservation){
        final result = await _apiRepository.confirmReservation(event.reservation);
        if(result.error){
          yield ReservationError(result.errorMessage as String);
        } else {
          yield ReservationConfirmed();
        }
      }
      

      if(event is IncrementUnits){
        yield* _addDish(event.indexAccount, event.indexOrder, event.indexDish);
      }

      if(event is DecrementUnits){
        yield* _deleteDish(event.indexAccount, event.indexOrder, event.indexDish);
      }

    } on NetworkError {
      yield ReservationError("Failed to fetch data. is your device online?");
    }
  }

  Stream<ReservationState> _addDish(int indexAccount, int indexOrder, int indexDish) async*{
      //unidades por plato
    state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units 
      = state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units! 
      + 1;
    //precio total de orden
    state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalPrice 
      = state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalPrice! 
      + state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].price!;
    //unidades totales por orden
    state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalUnits
      = state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalUnits!
      + 1 ;
    //precio total de cuenta
    /*state.reservationOrdersActive!.listAccount![indexAccount].subtotal 
      = state.reservationOrdersActive!.listAccount![indexAccount].subtotal! 
      + state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].price!;

    print(state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units);
    print(state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalPrice);
    print(state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalUnits);*/
    //print(state.reservationOrdersActive!.listAccount![indexAccount].subtotal );
    
    yield state.copyWith(reservationOrdersActive: state.reservationOrdersActive);
  }
  Stream<ReservationState> _deleteDish(int indexAccount, int indexOrder, int indexDish) async*{
    //unidades por plato
    state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units 
      = state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units! 
      - 1;
    //precio total de orden
    state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalPrice 
      = state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalPrice! 
      - state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].price!;
    //unidades totales por orden
    state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalUnits
      = state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalUnits!
      + 1 ;
    //precio total de cuenta
    /*state.reservationOrdersActive!.listAccount![indexAccount].subtotal 
      = state.reservationOrdersActive!.listAccount![indexAccount].subtotal! 
      - state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].price!;

    print(state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units);
    print(state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalPrice);
    print(state.reservationOrdersActive!.listAccount![indexAccount].listOrder![indexOrder].totalUnits);*/
    //print(state.reservationOrdersActive!.listAccount![indexAccount].subtotal );

    yield state.copyWith(reservationOrdersActive: state.reservationOrdersActive);
  }
}