import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/account/models/account_model.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;

class ApiProviderAccount{
  Future<APIResponse<Object>> getAccountListByClient(int uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.account}/listByUid/$uid'),
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
                .map((job) => AccountModel.fromJson(job))
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

  Future<APIResponse<Object>> setAccount(AccountModel account) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      var jsonRes = json.encode(account);
      final response = await http.post(Uri.parse(APIResources.account),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'From':'restserapp',
          },
          body: jsonRes);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return getAccount(response.body);
      } else {
        return APIResponse<bool>(error: true, errorMessage: response.body);
      }
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: 'Exception occured: $error stackTrace: $stacktrace');
    }
  }

  Future<APIResponse<Object>> setAccountList(List<AccountModel> list) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var jsonRes = json.encode(list);

      final response =
          await http.post(Uri.parse('${APIResources.account}/list'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
                'From':'restserapp',
              },
              body: jsonRes);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(error: false);
      }
      return APIResponse<bool>(error: true, errorMessage: response.body);
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<APIResponse<Object>> getAccount(String idAccount) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.account}/$idAccount'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'From':'restserapp',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(
            error: false,
            data: AccountModel.fromJson(json.decode(response.body)));
      } else {
        return APIResponse<bool>(error: true, errorMessage: response.body);
      }
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<APIResponse<Object>> getAccountList(String idReservation) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.account}/listByIdReservation/$idReservation'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'From':'restserapp',
        },
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List jsonResponse = json.decode(response.body);
        return APIResponse<Object>(
            error: false,
            data: jsonResponse
                .map((job) => AccountModel.fromJson(job))
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