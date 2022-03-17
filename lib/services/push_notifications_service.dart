import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<RemoteMessage> _messageStream = StreamController.broadcast();
  static Stream<RemoteMessage> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async{
    _messageStream.add(message);
  }

  static Future _onMessageHandler(RemoteMessage message) async{
    _messageStream.add(message);    
  }

  static Future _onMessageOpenApp(RemoteMessage message) async{    
    _messageStream.add(message);
  }  

  static _ShowToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.green,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 20,
    );
  }

  static Future initiallizeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    return token;
  }  
  static CloseStreams(){
    _messageStream.close();
  }
}