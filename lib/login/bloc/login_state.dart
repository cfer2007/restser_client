part of 'login_bloc.dart';

class LoginState {}

class LoginInitial extends LoginState {
  LoginInitial();
}

class LoginLoading extends LoginState {
  LoginLoading();
}

class LoginLoaded extends LoginState {
  LoginLoaded();
}

class FirebaseLoginLoaded extends LoginState {
  FirebaseLoginLoaded();
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

/*class LogOutSuccessState extends LoginState {
  
}*/
