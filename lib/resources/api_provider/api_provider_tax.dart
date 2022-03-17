import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:restser_client/tax/model/tax_model.dart';

class ApiProviderTax {
  Future<APIResponse<Object>> getTax(int idreservation) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();//await UserSecureStorage().getToken();
      final response = await http.get(
        Uri.parse('${APIResources.tax}/$idreservation'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'From':'restserapp',
        },
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(
            error: false,
            data: TaxModel.fromJson(json.decode(response.body)));
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