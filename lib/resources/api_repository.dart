import 'package:restser_client/login/bloc/model/firebase_signin_request_model.dart';
import 'package:restser_client/login/bloc/model/firebase_signup_request_model.dart';
import '/account/models/account_model.dart';
import '/contact/models/contact_model.dart';
import '/order/models/order_model.dart';
import '/order/models/order_detail_model.dart';
import '/reservation/models/reservation_model.dart';
import '/resources/api_response.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<APIResponse<Object>> signin(FirebaseSigninRequestModel user) {
    return _provider.signin(user);
  }

  Future<APIResponse<Object>> firebaseSignup(FirebaseSignupRequestModel user) {
    return _provider.firebaseSignup(user);
  }

  Future<APIResponse<Object>> getUserList(String idUser) {
    return _provider.getUserList(idUser);
  }

  Future<APIResponse<Object>> getMenuList(int idRestaurante) {
    return _provider.getMenuList(idRestaurante);
  }

  Future<APIResponse<Object>> getTable(String idTable) {
    return _provider.getTable(idTable);
  }

  Future<APIResponse<Object>> setReservation(ReservationModel reservation) {
    return _provider.postReservation(reservation);
  }

  Future<APIResponse<Object>> getReservation(String idReservation) {
    return _provider.getReservation(idReservation);
  }

  Future<APIResponse<Object>> setAccountList(List<AccountModel> accounts) {
    return _provider.setAccountList(accounts);
  }

  Future<APIResponse<Object>> setAccount(AccountModel account) {
    return _provider.setAccount(account);
  }

  Future<APIResponse<Object>> getBranchDishesList(
      String idBranch, String idMenu) {
    return _provider.getBranchDishesList(idBranch, idMenu);
  }

  Future<APIResponse<Object>> setOrder(OrderModel order) {
    return _provider.setOrder(order);
  }

  Future<APIResponse<Object>> getOrderListByClient(String idUser) {
    return _provider.getOrderListByClient(idUser);
  }

  Future<APIResponse<bool>> setDishesOrder(List<OrderDetailModel> dishes) {
    return _provider.setDishesOrder(dishes);
  }

  Future<APIResponse<Object>> getContactList(String idUser) {
    return _provider.getContactList(idUser);
  }

  Future<APIResponse<Object>> setContactList(List<ContactModel> list) {
    return _provider.setContactList(list);
  }

  Future<APIResponse<Object>> deleteContactList(List<ContactModel> list) {
    return _provider.deleteContactList(list);
  }

  Future<APIResponse<Object>> getAccountList(String idReservation) {
    return _provider.getAccountList(idReservation);
  }

  Future<APIResponse<Object>> getAccountListByClient(int idUser) {
    return _provider.getAccountListByClient(idUser);
  }
}

class NetworkError extends Error {}
