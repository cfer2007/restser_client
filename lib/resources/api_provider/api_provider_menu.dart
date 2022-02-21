import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/menu/model/menu_model.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;

class ApiProviderMenu{
  Future<APIResponse<Object>> getMenuList(String id) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      final response = await http.get(
        Uri.parse('${APIResources.menu}/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List jsonResponse = json.decode(response.body);
        return APIResponse<Object>(
          error: false,
          data: jsonResponse.map((job) => MenuModel.fromJson(job)).toList(),
        );
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