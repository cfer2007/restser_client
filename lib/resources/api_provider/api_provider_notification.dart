import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:restser_client/services/notification_model.dart';

class ApiProviderNotification {
  Future<APIResponse<Object>> sendNotification(NotificationModel notification) async {
    try{
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      var jsonNotification = json.encode(notification);
      final response =
          await http.post(Uri.parse('${APIResources.notification}/order_setted'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
                'From':'restserapp',
              },
              body: jsonNotification);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(error: false);
      } else {
        return APIResponse<bool>(error: true, errorMessage: response.body);
      }
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }
}