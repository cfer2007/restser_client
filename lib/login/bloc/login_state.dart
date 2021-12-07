part of 'login_bloc.dart';

class LoginState {
  //final UserModel? user;
  FirebaseResponseModel? loginUser;
  LoginState({this.loginUser});

  LoginState copyWith({
    FirebaseResponseModel? loginUser,
  }) {
    return LoginState(
      loginUser: loginUser ?? this.loginUser,
    );
  }

}

class LoginInitial extends LoginState {
  LoginInitial();
}

class LoginLoading extends LoginState {
  LoginLoading();
}

class LoginLoaded extends LoginState {
  //final UserModel user;
  LoginLoaded(/*this.user*/);
}

class FirebaseLoginLoaded extends LoginState {
  FirebaseLoginLoaded();
}

/*class SignupLoaded extends LoginState {
  String message;
  SignupLoaded(this.message);
}*/

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LogOutSuccessState extends LoginState {}
