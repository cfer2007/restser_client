import 'dart:async';
import 'package:restser_client/order/models/order_dish_model.dart';

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
      if (event is GetReservationAll) {
        yield ReservationLoading();
        print('GetReservationAll');
        final res = await _apiRepository.getReservation(event.idReservation.toString());
        if (res.error) {
          yield ReservationError(res.errorMessage as String);
        } else {
          state.copyWith(reservation: res.data as ReservationModel);
          yield ReservationLoadedAll(res.data as ReservationModel);
        }
      }
      if(event is ConfirmReservation){
        final result = await _apiRepository.confirmReservation(event.reservation);
        if(result.error){
          print('error ConfirmReservation ${result.errorMessage}');
          yield ReservationError(result.errorMessage as String);
        } else {
          yield ReservationConfirmed();
        }
      }
      if(event is Increment){
        yield* _addDish(event.indexAccount, event.indexOrder, event.indexDish);
      }

      if(event is Decrement){
        yield* _deleteDish(event.indexAccount, event.indexOrder, event.indexDish);
      }

    } on NetworkError {
      print('network error');
      yield ReservationError("Failed to fetch data. is your device online?");
    }
  }

  Stream<ReservationState> _addDish(int indexAccount, int indexOrder, int indexDish) async*{
    //unidades por plato
    state.reservation!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units 
      = state.reservation!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units! 
      + 1;
    //precio total de orden
    state.reservation!.listAccount![indexAccount].listOrder![indexOrder].totalPrice 
      = state.reservation!.listAccount![indexAccount].listOrder![indexOrder].totalPrice! 
      + state.reservation!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].price!;
    //unidades totales por orden
    state.reservation!.listAccount![indexAccount].listOrder![indexOrder].totalUnits
      = state.reservation!.listAccount![indexAccount].listOrder![indexOrder].totalUnits!
      + 1 ;
    //precio total de cuenta
    state.reservation!.listAccount![indexAccount].subtotal 
      = state.reservation!.listAccount![indexAccount].subtotal! 
      + state.reservation!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].price!;
    
    yield state.copyWith(reservation: state.reservation);
  }
  Stream<ReservationState> _deleteDish(int indexAccount, int indexOrder, int indexDish) async*{
    //unidades por plato
    state.reservation!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units 
      = state.reservation!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].units! 
      - 1;
    //precio total de orden
    state.reservation!.listAccount![indexAccount].listOrder![indexOrder].totalPrice 
      = state.reservation!.listAccount![indexAccount].listOrder![indexOrder].totalPrice! 
      - state.reservation!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].price!;
    //unidades totales por orden
    state.reservation!.listAccount![indexAccount].listOrder![indexOrder].totalUnits
      = state.reservation!.listAccount![indexAccount].listOrder![indexOrder].totalUnits!
      + 1 ;
    //precio total de cuenta
    state.reservation!.listAccount![indexAccount].subtotal 
      = state.reservation!.listAccount![indexAccount].subtotal! 
      - state.reservation!.listAccount![indexAccount].listOrder![indexOrder].listOrderDish![indexDish].price!;

    yield state.copyWith(reservation: state.reservation);
  }
}