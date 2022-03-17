import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/contact/models/contact_model.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;

class ApiProviderContact {
  Future<APIResponse<Object>> getContactList(String uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.contact}/$uid'),
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
            data: jsonResponse.map((job) => ContactModel.fromJson(job)).toList());
      } else {
        return APIResponse<bool>(error: true, errorMessage: response.body);
      }
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<APIResponse<Object>> setContactList(List<ContactModel> list) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var req = json.encode(list);
      final response =
          await http.post(Uri.parse('${APIResources.contact}/list'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
                'From':'restserapp',
              },
              body: req);
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

  Future<APIResponse<Object>> deleteContactList(List<ContactModel> list) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var req = json.encode(list);
      final response =
          await http.delete(Uri.parse('${APIResources.contact}/list'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
                'From':'restserapp',
              },
              body: req);
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