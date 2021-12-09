import 'package:restser_client/login/model/firebase_signin_request_model.dart';
import 'package:restser_client/login/model/firebase_signup_request_model.dart';
import 'package:restser_client/services/push_notifications_service.dart';
import '/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const users = {
  'abc@gmail.com': 'abc',
  'cf@gmail.com': '123',
};

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => const Duration(milliseconds: 2250);
  String val = 'error';

  Future<String> _authUser(LoginData data) async {
    BlocProvider.of<LoginBloc>(context)
        .add(FirebaseSignIn(FirebaseSigninRequestModel(email: data.name, password: data.password)));
    await Future.delayed(const Duration(seconds: 2));
    return val;
  }

  Future<String> _singupUser(SignupData data) async {
      WidgetsFlutterBinding.ensureInitialized();
      String token=await PushNotificationsService.initiallizeApp();
      BlocProvider.of<LoginBloc>(context).add(FirebaseSignUp(FirebaseSignupRequestModel(
        email: data.name,
        password: data.password,
        fcmToken: token,
      )));
      //await Future.delayed(const Duration(seconds: 2));
      return val;
    //}
  }

  Future<String> _recoverPassword(String email) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(email)) {
        return 'Username not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is FirebaseLoginLoaded) {
          val = '';
        }
        if (state is LoginError) {
          val = state.message;
        }
      },
      builder: (context, state) {
        return FlutterLogin(
          title: 'Client',
          //logo: 'assets/images/logo4.png',          
          onLogin: _authUser,
          onSignup: _singupUser,
          onRecoverPassword: _recoverPassword,
          navigateBackAfterRecovery: true,
          theme: LoginTheme(),
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacementNamed('/home', arguments: 0);
          },
          loginProviders: <LoginProvider>[
            LoginProvider(
              icon: FontAwesomeIcons.google,
              callback: () async {
                print('start google sign in');
                await Future.delayed(loginTime);
                print('stop google sign in');
                return null;
              },
            ),
            LoginProvider(
              icon: FontAwesomeIcons.facebookF,
              callback: () async {
                print('start facebook sign in');
                await Future.delayed(loginTime);
                print('stop facebook sign in');
                return null;
              },
            ),
            LoginProvider(
              icon: FontAwesomeIcons.linkedinIn,
              callback: () async {
                print('start linkdin sign in');
                await Future.delayed(loginTime);
                print('stop linkdin sign in');
                return null;
              },
            ),
          ],
          messages: LoginMessages(
            //userHint: 'User',
            //passwordHint: 'Pass',
            //confirmPasswordHint: 'Confirm',
            //loginButton: 'LOG IN',
            //signupButton: 'REGISTER',
            //forgotPasswordButton: 'Forgot huh?',
            recoverPasswordButton: 'HELP ME',
            goBackButton: 'BACK',
            //confirmPasswordError: 'Not match!',
            //recoverPasswordDescription:
            //    'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
            //recoverPasswordSuccess: 'Password rescued successfully',
          ),
          passwordValidator: (value) {
            if (value!.isEmpty) {
              return 'Password is empty';
            }
            if (value.length < 6) return 'Password is too short';
            return null;
          },
        );
      },
    );
  }
}
