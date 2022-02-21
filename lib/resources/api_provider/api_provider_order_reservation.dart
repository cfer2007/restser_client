import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/order_reservation/models/dishes_order_reservation_model.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;

class ApiProviderOrderReservation {
  Future<APIResponse<Object>> getOrderReservationList(String uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      if(uid.isNotEmpty){
        final response = await http.get(
          Uri.parse('${APIResources.orderReservation}/list/$uid'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        print(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          List jsonResponse = json.decode(response.body);
          return APIResponse<Object>(
            error: false,
            data: jsonResponse.map((job) => DishesOrderReservationModel.fromJson(job)).toList());
        } else {
          return APIResponse<bool>(error: true, errorMessage: response.body);
        }
      }
      else {
          return APIResponse<bool>(error: true, errorMessage: 'idReservation is null');
        }
      
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }
}