import 'dart:async';

import '/user/models/user_model.dart';
import '/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiRepository _apiRepository = ApiRepository();
  UserBloc() : super(UserInitial());

  //List<ContactModel> contactList = [];

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    try {
      if (event is GetUserList) {
        {
          yield UserLoading();
          final userList = await _apiRepository.getUserList(event.idUser);
          if (userList.error) {
            yield UserError(userList.errorMessage as String);
          } else {
            yield UserListLoaded(userList.data as List<UserModel>);
          }
        }
      }
    } catch (e) {
      print('error: user_bloc: ' + e.toString());
    }
  }
}
