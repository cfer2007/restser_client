import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/order/models/order_model.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;

class ApiProviderOrder{
  Future<APIResponse<Object>> setOrder(OrderModel order) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var jsonOrder = json.encode(order);
      print(jsonOrder);
      final response = await http.post(Uri.parse(APIResources.order),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonOrder);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(error: false, data: response.body);
      } else {
        return APIResponse<bool>(error: true, errorMessage: response.body);
      }
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: 'Exception occured: $error stackTrace: $stacktrace');
    }
  }
}