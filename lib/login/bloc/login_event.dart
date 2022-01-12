part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class AuthUser extends LoginEvent {
  final AuthUserRequestModel user;
  AuthUser(this.user);
}

class SignOut extends LoginEvent {
  SignOut();
}
