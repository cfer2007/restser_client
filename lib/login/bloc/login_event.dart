part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class AuthUser extends LoginEvent {
  final AuthUserRequestModel user;
  User firebaseUser;
  AuthUser(this.user, this.firebaseUser);
}

class SignOut extends LoginEvent {
  SignOut();
}
