//import 'package:restser_client/login/model/signin_email_request_model.dart';
import 'package:restser_client/login/model/auth_user_request_model.dart';
import 'package:restser_client/services/push_notifications_service.dart';
import '/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

const users = {
  'abc@gmail.com': 'abc',
  'cfer86@gmail.com': '123',
};

final FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email',],);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => const Duration(milliseconds: 2250);
  String val = 'error';

  addUserBloc(FirebaseAuth _auth) async{
    BlocProvider.of<LoginBloc>(context).add(AuthUser(AuthUserRequestModel(
        uid: _auth.currentUser!.uid,
        email: _auth.currentUser!.email, 
        fcmToken: await PushNotificationsService.initiallizeApp())));
  }

  Future<String> _signInWithEmailAndPassword(LoginData data) async {
    try {                  
      await _auth.signInWithEmailAndPassword(email: data.name, password: data.password);
      addUserBloc(_auth);
      return '';
    } catch (error) {
      return 'error';
    }    
  }

  Future<String> _signInWithGoogle() async {
    try {                  
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication gsa = await googleSignInAccount!.authentication;
      await _auth.signInWithCredential(GoogleAuthProvider.credential(idToken: gsa.idToken, accessToken: gsa.accessToken));
      addUserBloc(_auth);
      
      return '';
    } catch (error) {
      return 'error';
    }    
  }

  Future<String> _signInWithFacebook() async {
    try{
      final result = await FacebookAuth.i.login(permissions: ["public_profile", "email"]);
      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
        await _auth.signInWithCredential(facebookAuthCredential);
        addUserBloc(_auth);
        return '';
      }
      else { return 'error: ${result.message}'; }
    }
    catch(error){
      return 'error';
    }
  }

  Future<String> _singupUserWithEmailAndPassword(SignupData data) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: data.name!, password: data.password!);
      BlocProvider.of<LoginBloc>(context).add(AuthUser(AuthUserRequestModel(
        uid: _auth.currentUser!.uid,
        email: _auth.currentUser!.email, 
        fcmToken: await PushNotificationsService.initiallizeApp())));
      return '';
    }
    catch(error){
      return 'error';
    }
      
  }

  Future<String> _recoverPassword(String email) async{
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(email)) {
        return 'User not exists';
      }
      else {
        try{
          _auth.sendPasswordResetEmail(email: email);
          return '';
        }
        catch(error){
          print('error: $error');
          return error.toString();
        }        
      }
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
          onLogin: _signInWithEmailAndPassword,//WithEmainPassword,
          onSignup: _singupUserWithEmailAndPassword,
          onRecoverPassword: _recoverPassword,
          navigateBackAfterRecovery: false,
          theme: LoginTheme(),
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacementNamed('/home', arguments: 0);
          },
          loginProviders: <LoginProvider>[
            LoginProvider(
              icon: FontAwesomeIcons.google,
              callback: () async {
                return _signInWithGoogle();
              },
            ),
            LoginProvider(
              icon: FontAwesomeIcons.facebookF,
              callback: () async {
                return _signInWithFacebook();                
              },
            ),
          ],
          messages: LoginMessages(            
            recoverPasswordButton: 'HELP ME',
            goBackButton: 'BACK',
            recoverPasswordDescription:'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
            recoverPasswordSuccess: 'Password rescued successfully',
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
