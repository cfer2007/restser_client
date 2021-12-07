part of 'user_bloc.dart';

class UserState {
  List<UserModel>? userList = [];

  UserState({this.userList});

  UserState copyWith({
    List<UserModel>? userList,
  }) {
    return UserState(
      userList: userList ?? this.userList,
    );
  }
}

class UserInitial extends UserState {
  UserInitial();
}

class UserLoading extends UserState {
  UserLoading();
}

class UserListLoaded extends UserState {
  List<UserModel>? userList;
  UserListLoaded(this.userList);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
