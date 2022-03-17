import 'package:http/http.dart' as http;
import 'package:restser_client/login/model/auth_user_request_model.dart';
import 'dart:convert';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';

class ApiProviderAuth {
  Future<APIResponse<Object>> authUser(AuthUserRequestModel user) async {
    try {
      String jsonSignup = json.encode(user.toJson());
      final response = await http.post(Uri.parse(APIResources.authUser),
          headers: APIResources.header, body: jsonSignup);
      final parsedJson = json.decode(response.body);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(
            error: false, 
            data: response.body);       
      }
      return APIResponse<bool>(
          error: true, errorMessage: parsedJson['message']);
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }
}