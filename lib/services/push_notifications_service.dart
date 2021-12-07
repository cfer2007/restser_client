import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future _backgroundHandler(RemoteMessage message) async{
    print('_backgroundHandler ${message.messageId}');
  }

  static Future _onMessageHandler(RemoteMessage message) async{
    print('_onMessageHandler ${message.messageId}');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async{
    print('_onMessageOpenApp ${message.messageId}');
  }  

  static Future initiallizeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    //print(token); //dTB9NafVQAWHVKKUKzx5ou:APA91bHsrgI_nJ71u2_IqlDcsbkdVEfR8kQcIPuqtLZEECt2yIII5PDGdLCMqyj-NYelhw-CDrxR8bJgCc16dBZvrhRMyfXUS6lzW7yKfuHh2aN3FnJSvnu1FhGSR_Vc5Fnd49k10jYX

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    return token;

  }
}