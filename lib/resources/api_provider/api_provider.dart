import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/login/model/auth_user_request_model.dart';
import 'package:restser_client/services/notification_model.dart';
import '/account/models/account_model.dart';
import '/contact/models/contact_model.dart';
import '/dish/models/dish_model.dart';
import '/menu/model/menu_model.dart';
import '/user/models/user_model.dart';
import '/order/models/order_model.dart';
import '../../order/models/order_dish_model.dart';
import '/reservation/models/reservation_model.dart';
import '/resources/api_resources.dart';
import '/resources/api_response.dart';
import '/table/model/table_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider{   

  /*Future<APIResponse<Object>> authUser(AuthUserRequestModel user) async {
    try {
      String jsonSignup = json.encode(user.toJson());
      final response = await http.post(Uri.parse(APIResources.authUser),
          headers: APIResources.header, body: jsonSignup);
      final parsedJson = json.decode(response.body);
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
  }*/

  /*Future<APIResponse<Object>> getUserList(String uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.user}/$uid'),
        headers: {
          'Authorization': 'Bearer $token',
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
  }*/

  /*Future<APIResponse<Object>> getMenuList(String id) async {
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
  }*/

  /*Future<APIResponse<Object>> getTable(String idTable) async {
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
  }*/

  /*Future<APIResponse<Object>> postReservation(ReservationModel res) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      String jsonRes = json.encode(res.toJson());
      print(jsonRes);
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
        //print(response.body);
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
  Future<APIResponse<Object>> confirmReservation(ReservationModel res) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      String jsonRes = json.encode(res.toJsonConfirm());
      print(jsonRes);
      final response = await http.put(Uri.parse(APIResources.reservation),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonRes);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIResponse<Object>(
              error: false,
              data: response.body);
      } else {
        return APIResponse<bool>(error: true, errorMessage: response.body);
      }
      //return APIResponse<bool>(error: true, errorMessage: '');
    } catch (error, stacktrace) {
      return APIResponse<bool>(
          error: true,
          errorMessage: "Exception occured: $error stackTrace: $stacktrace");
    }
  }*/

  /*Future<APIResponse<Object>> getAccountListByClient(int uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.account}/list/$uid'),
        headers: {
          'Authorization': 'Bearer $token',
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
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      var jsonRes = json.encode(account);
      final response = await http.post(Uri.parse(APIResources.account),
          headers: {
            'Authorization': 'Bearer $token',
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
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var jsonRes = json.encode(list);

      final response =
          await http.post(Uri.parse('${APIResources.account}/list'),
              headers: {
                'Authorization': 'Bearer $token',
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
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.account}/$idAccount'),
        headers: {
          'Authorization': 'Bearer $token',
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
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.account}/reservation/$idReservation'),
        headers: {
          'Authorization': 'Bearer $token',
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
  }*/

  /*Future<APIResponse<Object>> getBranchDishesList(
      String idBranch, String idMenu) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.branchDish}/$idBranch/$idMenu'),
        headers: {
          'Authorization': 'Bearer $token',
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
  }*/

  /*Future<APIResponse<Object>> getOrderListByClient(String uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.order}/user/$uid'),
        headers: {
          'Authorization': 'Bearer $token',
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
  }*/

  /*Future<APIResponse<Object>> setOrder(OrderModel order) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var jsonOrder = json.encode(order);
      final response = await http.post(Uri.parse(APIResources.order),
          headers: {
            'Authorization': 'Bearer $token',
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
  }*/

  /*Future<APIResponse<bool>> setDishesOrder(List<OrderDishModel> dishes) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var jsonDishes = json.encode(dishes);
      final response = await http.post(Uri.parse(APIResources.orderDetail),
          headers: {
            'Authorization': 'Bearer $token',
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
  }*/

  /*Future<APIResponse<Object>> getContactList(String uid) async {
    try {
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse('${APIResources.contact}/$uid'),
        headers: {
          'Authorization': 'Bearer $token',
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
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var req = json.encode(list);
      final response =
          await http.post(Uri.parse('${APIResources.contact}/list'),
              headers: {
                'Authorization': 'Bearer $token',
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
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      var req = json.encode(list);
      final response =
          await http.delete(Uri.parse('${APIResources.contact}/list'),
              headers: {
                'Authorization': 'Bearer $token',
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
  }*/
  /*Future<APIResponse<Object>> sendNotification(NotificationModel notification) async {
    try{
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();
      var jsonNotification = json.encode(notification);
      final response =
          await http.post(Uri.parse('${APIResources.notification}/order_setted'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: jsonNotification);
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
  }*/
}
