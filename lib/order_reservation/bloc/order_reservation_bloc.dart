import 'package:bloc/bloc.dart';
import 'package:restser_client/order_reservation/models/dishes_order_reservation_model.dart';
import 'dart:async';
import 'package:restser_client/resources/api_repository.dart';

part 'order_reservation_event.dart';
part 'order_reservation_state.dart';

class OrderReservationBloc extends Bloc<OrderReservationEvent, OrderReservationState> {
  OrderReservationBloc() : super(OrderReservationInitial());

  final ApiRepository _apiRepository = ApiRepository();

  @override
      Stream<OrderReservationState> mapEventToState(
        OrderReservationEvent event,
      ) async* {
        try{
          if(event is GetOrderReservationList){
        final result = await _apiRepository.getOrderReservationList(event.uid!);
        if(result.error){
          yield OrderReservationError(result.errorMessage as String);
        }
        else{
          yield OrderReservationListLoaded(result.data as List<DishesOrderReservationModel>);
        }
      }
        }
        on NetworkError {
          yield OrderReservationError("Failed to fetch data. is your device online?");
        }
      }
}
