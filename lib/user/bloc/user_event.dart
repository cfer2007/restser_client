part of 'user_bloc.dart';

class UserEvent {
  const UserEvent();
}

class GetUserList extends UserEvent {
  String idUser;
  GetUserList(this.idUser);
}
