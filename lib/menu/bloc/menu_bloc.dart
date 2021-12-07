import 'dart:async';

import '/menu/model/menu_model.dart';
import '/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final ApiRepository _apiRepository = ApiRepository();

  MenuBloc() : super(MenuInitial());

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    if (event is GetMenuList) {
      try {
        yield MenuLoading();
        final menuList = await _apiRepository.getMenuList(event.idRestaurante);
        if (menuList.error) {
          yield MenuError(menuList.errorMessage as String);
        } else {
          yield MenuListLoaded(menuList.data as List<MenuModel>);
        }
      } on NetworkError {
        yield MenuError("Failed to fetch data. is your device online?");
      }
    }
  }
}
