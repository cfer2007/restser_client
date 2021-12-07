part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class FirebaseSignIn extends LoginEvent {
  final FirebaseSigninRequestModel user;
  FirebaseSignIn(this.user);
}

class FirebaseSignUp extends LoginEvent {
  final FirebaseSignupRequestModel loginUser;
  FirebaseSignUp(this.loginUser);
}

class SignOut extends LoginEvent {
  SignOut();
}
