import 'package:restser_client/login/model/auth_user_request_model.dart';
import 'package:restser_client/services/notification_model.dart';
import '/account/models/account_model.dart';
import '/contact/models/contact_model.dart';
import '/order/models/order_model.dart';
import '../order/models/order_dish_model.dart';
import '/reservation/models/reservation_model.dart';
import '/resources/api_response.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<APIResponse<Object>> authUser(AuthUserRequestModel user) {
    return _provider.authUser(user);
  }

  Future<APIResponse<Object>> getUserList(String uid) {
    return _provider.getUserList(uid);
  }

  Future<APIResponse<Object>> getMenuList(String idRestaurante) {
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

  Future<APIResponse<Object>> confirmReservation(ReservationModel reservation) {
    return _provider.confirmReservation(reservation);
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

  /*Future<APIResponse<Object>> getOrderListByClient(String uid) {
    return _provider.getOrderListByClient(uid);
  }*/

  Future<APIResponse<bool>> setDishesOrder(List<OrderDishModel> dishes) {
    return _provider.setDishesOrder(dishes);
  }

  Future<APIResponse<Object>> getContactList(String uid) {
    return _provider.getContactList(uid);
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

  Future<APIResponse<Object>> getAccountListByClient(int uid) {
    return _provider.getAccountListByClient(uid);
  }
  Future<APIResponse<Object>> sendNotification(NotificationModel notification){
    return _provider.sendNotification(notification);
  }
}

class NetworkError extends Error {}
