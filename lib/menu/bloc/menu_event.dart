part of 'menu_bloc.dart';

abstract class MenuEvent {
  //} extends Equatable {
  const MenuEvent();
}

class GetMenuList extends MenuEvent {
  final String idRestaurante;
  GetMenuList(this.idRestaurante);
}
