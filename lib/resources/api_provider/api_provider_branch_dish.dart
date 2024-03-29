import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/dish/models/dish_model.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;

class ApiProviderBranchDish{
  Future<APIResponse<Object>> getBranchDishesList(
      String idBranch, String idMenu) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.branchDish}/$idBranch/$idMenu'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'From':'restserapp',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List jsonResponse = json.decode(response.body);
        return APIResponse<Object>(
            error: false,
            data: jsonResponse
                .map((job) => DishModel.fromJson(job))
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