part of 'dish_bloc.dart';

abstract class DishEvent {
  const DishEvent();
}

class GetDishList extends DishEvent {
  final String idBrach;
  final String idMenu;
  GetDishList(this.idBrach, this.idMenu);
}
