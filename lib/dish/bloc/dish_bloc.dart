import 'dart:async';

import '/dish/models/dish_model.dart';
import '/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

part 'dish_event.dart';
part 'dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  final ApiRepository _apiRepository = ApiRepository();
  DishBloc() : super(const DishInitial());

  @override
  Stream<DishState> mapEventToState(
    DishEvent event,
  ) async* {
    if (event is GetDishList) {
      try {
        yield const DishLoading();
        final dishList = await _apiRepository.getBranchDishesList(
            event.idBrach, event.idMenu);
        if (dishList.error) {
          yield DishError(dishList.errorMessage as String);
        } else {
          yield DishLoaded(dishList.data as List<DishModel>);
        }
      } on NetworkError {
        yield const DishError("Failed to fetch data. is your device online?");
      }
    }
  }
}
