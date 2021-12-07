part of 'dish_bloc.dart';

abstract class DishState {
  const DishState();
}

class DishInitial extends DishState {
  const DishInitial();
}

class DishLoading extends DishState {
  const DishLoading();
}

class DishLoaded extends DishState {
  final List<DishModel> dishList;
  const DishLoaded(this.dishList);
}

class DishError extends DishState {
  final String message;
  const DishError(this.message);
}
