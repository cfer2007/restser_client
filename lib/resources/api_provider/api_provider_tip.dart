import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:restser_client/tip/model/tip_model.dart';

class ApiProviderTip {
  Future<APIResponse<Object>> getListTip(int idreservation) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();//await UserSecureStorage().getToken();
      final response = await http.get(
        Uri.parse('${APIResources.tip}/$idreservation'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'From':'restserapp',
        },
      );
      //print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List jsonResponse = json.decode(response.body);
        return APIResponse<Object>(
            error: false,
            data: jsonResponse
                .map((job) => TipModel.fromJson(job))
                .toList());
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