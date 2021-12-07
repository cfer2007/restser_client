import 'dart:convert';
import 'package:restser_client/login/bloc/model/firebase_auth_response_model.dart';
import 'package:restser_client/login/bloc/model/firebase_signin_request_model.dart';
import 'package:restser_client/login/bloc/model/firebase_signup_request_model.dart';
import '../login/widgets/user_secure_storage.dart';
import '/account/models/account_model.dart';
import '/contact/models/contact_model.dart';
import '/dish/models/dish_model.dart';
import '/menu/model/menu_model.dart';
import '/user/models/user_model.dart';
import '/order/models/order_model.dart';
import '/order/models/order_detail_model.dart';
import '/reservation/models/reservation_model.dart';
import '/resources/api_resources.dart';
import '/resources/api_response.dart';
import '/table/model/table_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider{

    Future<APIResponse<Object>> signin(FirebaseSigninRequestModel user) async {
    try {      
      String jsonUser = json.encode(user.toJson());
      final response = await http.post(Uri.parse(APIResources.firebaseSignIn),      
          headers: APIResources.headerLogin, body: jsonUser);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(
            error: false, 
            data: FirebaseResponseModel.fromJson(json.decode(response.body))); 
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<APIResponse<Object>> firebaseSignup(FirebaseSignupRequestModel user) async {
    try {
      String jsonSignup = json.encode(user.toJson());
      final response = await http.post(Uri.parse(APIResources.firebasesignUp),
          headers: APIResources.headerLogin, body: jsonSignup);
      final parsedJson = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(
            error: false, 
            data: FirebaseResponseModel.fromJson(json.decode(response.body)));       
      }
      return APIResponse<bool>(
          error: true, errorMessage: parsedJson['message']);
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<APIResponse<Object>> getUserList(String idUser) async {
    try {
      final response = await http.get(
        Uri.parse('${APIResources.user}/$idUser'),
        headers: {
          //HttpHeaders.AUTHORIZATION: await UserSecureStorage().getToken().toString(),
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        List jsonResponse = json.decode(response.body);
        return APIResponse<Object>(
          error: false,
          data: jsonResponse.map((job) => UserModel.fromJson(job)).toList(),
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

  Future<APIResponse<Object>> getMenuList(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${APIResources.menu}/$id'),
        headers: {
          //HttpHeaders.authorizationHeader:
          //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
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

  Future<APIResponse<Object>> getTable(String idTable) async {
    try {
      final token =await UserSecureStorage().getToken();
      
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

  Future<APIResponse<Object>> postReservation(ReservationModel res) async {
    try {
      String jsonRes = json.encode(res.toJson());
      final response = await http.post(Uri.parse(APIResources.reservation),
          headers: {
            //HttpHeaders.authorizationHeader:
            //   '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
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
      final response = await http.get(
        Uri.parse('${APIResources.reservation}/$idReservation'),
        headers: {
          //HttpHeaders.authorizationHeader:
          //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
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
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<APIResponse<Object>> getAccountListByClient(int idUser) async {
    try {
      final response = await http.get(
        Uri.parse('${APIResources.account}/list/$idUser'),
        headers: {
          //HttpHeaders.authorizationHeader:
          //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List jsonResponse = json.decode(response.body);
        //print(jsonResponse);
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
      var jsonRes = json.encode(account);
      final response = await http.post(Uri.parse(APIResources.account),
          headers: {
            //HttpHeaders.authorizationHeader:
            //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
            'Content-Type': 'application/json',
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
      var jsonRes = json.encode(list);

      final response =
          await http.post(Uri.parse('${APIResources.account}/list'),
              headers: {
                //HttpHeaders.authorizationHeader:
                //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
                'Content-Type': 'application/json',
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
      final response = await http.get(
        Uri.parse('${APIResources.account}/$idAccount'),
        headers: {
          //HttpHeaders.authorizationHeader:
          //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
          'Content-Type': 'application/json',
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
      final response = await http.get(
        Uri.parse('${APIResources.account}/reservation/$idReservation'),
        headers: {
          //HttpHeaders.authorizationHeader:
          //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
          'Content-Type': 'application/json',
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

  Future<APIResponse<Object>> getBranchDishesList(
      String idBranch, String idMenu) async {
    try {
      final response = await http.get(
        Uri.parse('${APIResources.branchDish}/$idBranch/$idMenu'),
        headers: {
          //HttpHeaders.authorizationHeader:
          //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
          'Content-Type': 'application/json',
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

  Future<APIResponse<Object>> getOrderListByClient(String idUser) async {
    try {
      final response = await http.get(
        Uri.parse('${APIResources.order}/user/$idUser'),
        headers: {
          //HttpHeaders.authorizationHeader:
          //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List jsonResponse = json.decode(response.body);
        return APIResponse<Object>(
            error: false,
            data: jsonResponse
                .map((job) => OrderModel.fromJson(job))
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

  Future<APIResponse<Object>> setOrder(OrderModel order) async {
    try {
      var jsonOrder = json.encode(order);
      final response = await http.post(Uri.parse(APIResources.order),
          headers: {
            //HttpHeaders.authorizationHeader:
            //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
            'Content-Type': 'application/json',
          },
          body: jsonOrder);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(error: false, data: response.body);
      } else {
        return APIResponse<bool>(error: true, errorMessage: response.body);
      }
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: 'Exception occured: $error stackTrace: $stacktrace');
    }
  }

  Future<APIResponse<bool>> setDishesOrder(
      List<OrderDetailModel> dishes) async {
    try {
      var jsonDishes = json.encode(dishes);
      final response = await http.post(Uri.parse(APIResources.orderDetail),
          headers: {
            //HttpHeaders.authorizationHeader:
            //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
            'Content-Type': 'application/json',
          },
          body: jsonDishes);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<bool>(error: false);
      } else {
        return APIResponse<bool>(error: true, errorMessage: response.body);
      }
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: 'Exception occured: $error stackTrace: $stacktrace');
    }
  }

  Future<APIResponse<Object>> getContactList(String idUser) async {
    try {
      final response = await http.get(
        Uri.parse('${APIResources.contact}/$idUser'),
        headers: {
          //HttpHeaders.authorizationHeader:
          //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List jsonResponse = json.decode(response.body);
        return APIResponse<Object>(
            error: false,
            data: jsonResponse
                .map((job) => ContactModel.fromJson(job))
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

  Future<APIResponse<Object>> setContactList(List<ContactModel> list) async {
    try {
      var req = json.encode(list);
      final response =
          await http.post(Uri.parse('${APIResources.contact}/list'),
              headers: {
                //HttpHeaders.authorizationHeader:
                //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
                'Content-Type': 'application/json',
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
      var req = json.encode(list);
      final response =
          await http.delete(Uri.parse('${APIResources.contact}/list'),
              headers: {
                //HttpHeaders.authorizationHeader:
                //    '${await FlutterSession().get("tokenType")} ${await FlutterSession().get("accessToken")}',
                'Content-Type': 'application/json',
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

  /*@override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }*/
}
