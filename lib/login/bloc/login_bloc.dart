import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/login/model/auth_user_request_model.dart';
import 'package:restser_client/login/widgets/user_secure_storage.dart';
import '/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository _apiRepository = ApiRepository();
  //final UserSecureStorage userRepository;
  LoginBloc(/*this.userRepository*/) : super(LoginInitial());
  

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is AuthUser){
        yield LoginLoading();
        final result = await _apiRepository.authUser(event.user);
        if(result.error){
          yield LoginError(result.errorMessage as String);
        }
        else {
          /*userRepository.setLoginData(event.user.email!, 
            await FirebaseAuth.instance.currentUser!.getIdToken(), 
            FirebaseAuth.instance.currentUser!.uid);*/
          yield FirebaseLoginLoaded();
        }
      }
      /*else if (event is SignOut) {        
        LogOutSuccessState();
      }*/
    } on NetworkError {
      yield LoginError("Failed to fetch data. is your device online?");
    }
  }
}
