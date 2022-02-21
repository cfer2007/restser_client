import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:restser_client/table/model/table_model.dart';

class ApiProviderTable {
  Future<APIResponse<Object>> getTable(String idTable) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();//await UserSecureStorage().getToken();
      final response = await http.get(
        Uri.parse('${APIResources.table}/$idTable'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(
            error: false,
            data: TableModel.fromJson(json.decode(response.body)));
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