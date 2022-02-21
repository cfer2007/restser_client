import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/order/models/order_dish_model.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;

class ApiProviderOrderDish{
  Future<APIResponse<bool>> setDishesOrder(List<OrderDishModel> dishes) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var jsonDishes = json.encode(dishes);
      final response = await http.post(Uri.parse(APIResources.orderDish),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonDishes);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<bool>(error: false);
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