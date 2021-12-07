part of 'menu_bloc.dart';

abstract class MenuState {
  final List<MenuModel>? menuList;
  MenuState({this.menuList});
}

class MenuInitial extends MenuState {
  MenuInitial();
}

class MenuLoading extends MenuState {
  MenuLoading();
}

class MenuListLoaded extends MenuState {
  final List<MenuModel> menuList;
  MenuListLoaded(this.menuList);
}

class MenuError extends MenuState {
  final String message;
  MenuError(this.message);
}
