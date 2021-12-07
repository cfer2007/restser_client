import 'dart:async';
import 'package:restser_client/login/bloc/model/firebase_auth_response_model.dart';
import 'package:restser_client/login/bloc/model/firebase_signin_request_model.dart';
import 'package:restser_client/login/bloc/model/firebase_signup_request_model.dart';
import 'package:restser_client/login/widgets/user_secure_storage.dart';
import '/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository _apiRepository = ApiRepository();
  final UserSecureStorage userRepository;
  LoginBloc(this.userRepository) : super(LoginInitial());
  

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is FirebaseSignIn) {
        yield LoginLoading();
        final firebaseSignIn = await _apiRepository.signin(event.user);

        if (firebaseSignIn.error) {
          yield LoginError(firebaseSignIn.errorMessage as String);
        } else {
          FirebaseResponseModel user = firebaseSignIn.data as FirebaseResponseModel;
          userRepository.setLoginData(user.email!, user.idToken!, user.uid!);
          yield FirebaseLoginLoaded();
        }
      } else if (event is SignOut) {
        LogOutSuccessState();

      } 
      else if (event is FirebaseSignUp) {
        final _signup = await _apiRepository.firebaseSignup(event.loginUser);        
        if (_signup.error) {
          yield LoginError(_signup.errorMessage.toString());
        } else {
          FirebaseResponseModel user = _signup.data as FirebaseResponseModel;
          userRepository.setLoginData(user.email!, user.idToken!, user.uid!);
          yield FirebaseLoginLoaded();
        }
      }
    } on NetworkError {
      yield LoginError("Failed to fetch data. is your device online?");
    }
  }
}
