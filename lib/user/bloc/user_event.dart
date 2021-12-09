part of 'user_bloc.dart';

class UserEvent {
  const UserEvent();
}

class GetUserList extends UserEvent {
  String uid;
  GetUserList(this.uid);
}
