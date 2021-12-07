part of 'menu_bloc.dart';

abstract class MenuEvent {
  //} extends Equatable {
  const MenuEvent();
}

class GetMenuList extends MenuEvent {
  final int idRestaurante;
  GetMenuList(this.idRestaurante);
}
