import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/reservation/models/reservation_finish_model.dart';
import 'package:restser_client/reservation/models/reservation_model.dart';
import 'package:restser_client/reservation/models/reservation_active_model.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/resources/api_response.dart';
import 'package:http/http.dart' as http;

class ApiProviderReservation {
  Future<APIResponse<Object>> postReservation(ReservationModel res) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      String jsonRes = json.encode(res.toJson());
      final response = await http.post(Uri.parse(APIResources.reservation),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonRes);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return getReservation(response.body);
      } else {
        return APIResponse<bool>(error: true, errorMessage: response.body);
      }
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<APIResponse<Object>> getReservation(String idReservation) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      if(idReservation.isNotEmpty){
        final response = await http.get(
          Uri.parse('${APIResources.reservation}/$idReservation'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          return APIResponse<Object>(
              error: false,
              data: ReservationModel.fromJson(json.decode(response.body)));
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
  Future<APIResponse<Object>> getActiveReservation(String uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      if(uid.isNotEmpty){
        final response = await http.get(
          Uri.parse('${APIResources.reservation}/active/$uid'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        //print('response.body ${response.body}');
        if (response.statusCode == 200 || response.statusCode == 201) {
          return APIResponse<Object>(
              error: false,
              data: ReservationModel.fromJson(json.decode(response.body)));
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
  Future<APIResponse<Object>> getFinishReservationList(String uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      if(uid.isNotEmpty){
        final response = await http.get(
          Uri.parse('${APIResources.reservation}/list/$uid'),
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
            data: jsonResponse
                .map((job) => ReservationFinishModel.fromJson(job))
                .toList());
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

  Future<APIResponse<Object>> getOrdersActiveByReservation(String uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      if(uid.isNotEmpty){
        final response = await http.get(
          Uri.parse('${APIResources.reservation}/reservation_active/$uid'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        //print(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          return APIResponse<Object>(
              error: false,
              data: ReservationActiveModel.fromJson(json.decode(response.body)));
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

  Future<APIResponse<Object>> confirmReservation(ReservationModel res) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      String jsonRes = json.encode(res.toJsonConfirm());
      final response = await http.put(Uri.parse(APIResources.reservation),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonRes);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(
              error: false,
              data: response.body);
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
