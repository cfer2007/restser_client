import 'package:restser_client/account/models/collect_account_model.dart';
import 'package:restser_client/login/model/auth_user_request_model.dart';
import 'package:restser_client/reservation/models/reservation_active_model.dart';
import 'package:restser_client/resources/api_provider/api_provider_account.dart';
import 'package:restser_client/resources/api_provider/api_provider_auth.dart';
import 'package:restser_client/resources/api_provider/api_provider_branch_dish.dart';
import 'package:restser_client/resources/api_provider/api_provider_contact.dart';
import 'package:restser_client/resources/api_provider/api_provider_menu.dart';
import 'package:restser_client/resources/api_provider/api_provider_notification.dart';
import 'package:restser_client/resources/api_provider/api_provider_order.dart';
import 'package:restser_client/resources/api_provider/api_provider_order_dish.dart';
import 'package:restser_client/resources/api_provider/api_provider_order_reservation.dart';
import 'package:restser_client/resources/api_provider/api_provider_reservation.dart';
import 'package:restser_client/resources/api_provider/api_provider_table.dart';
import 'package:restser_client/resources/api_provider/api_provider_tax.dart';
import 'package:restser_client/resources/api_provider/api_provider_tip.dart';
import 'package:restser_client/resources/api_provider/api_provider_user.dart';
import 'package:restser_client/services/notification_model.dart';
import '/account/models/account_model.dart';
import '/contact/models/contact_model.dart';
import '/order/models/order_model.dart';
import '../order/models/order_dish_model.dart';
import '/reservation/models/reservation_model.dart';
import '/resources/api_response.dart';
//import 'api_provider/api_provider.dart';

class ApiRepository {
  //final _provider = ApiProvider();  
  final _providerAuth = ApiProviderAuth();
  final _providerUser = ApiProviderUser();
  final _providerTable = ApiProviderTable();
  final _providerAccount = ApiProviderAccount();
  final _providerMenu = ApiProviderMenu();
  final _providerOrder = ApiProviderOrder();
  final _providerOrderDish = ApiProviderOrderDish();
  final _providerBranchDish = ApiProviderBranchDish();
  final _providerContact = ApiProviderContact();
  final _providerNotification = ApiProviderNotification();
  final _providerReservation = ApiProviderReservation();
  final _providerOrderReservation = ApiProviderOrderReservation();
  final _providerTip = ApiProviderTip();
  final _providerTax = ApiProviderTax();

  //--------------------- AUTH ---------------------------
  Future<APIResponse<Object>> authUser(AuthUserRequestModel user) {
    return _providerAuth.authUser(user);
  }

  //--------------------- USER ---------------------------
  Future<APIResponse<Object>> getUserList(String uid) {
    return _providerUser.getUserList(uid);
  }
  //--------------------- MENU ---------------------------
  Future<APIResponse<Object>> getMenuList(String idRestaurante) {
    return _providerMenu.getMenuList(idRestaurante);
  }
  //--------------------- TABLE ---------------------------
  Future<APIResponse<Object>> getTable(String idTable) {
    return _providerTable.getTable(idTable);
  }
  //--------------------- ACCOUNT ---------------------------
  Future<APIResponse<Object>> setAccountList(List<AccountModel> accounts) {
    return _providerAccount.setAccountList(accounts);
  }

  Future<APIResponse<Object>> setAccount(AccountModel account) {
    return _providerAccount.setAccount(account);
  }

  Future<APIResponse<Object>> getAccountList(String idReservation) {
    return _providerAccount.getAccountList(idReservation);
  }

  Future<APIResponse<Object>> getCollectAccountList(int idReservation) {
    return _providerAccount.getCollectAccountList(idReservation);
  }

  Future<APIResponse<Object>> getAccountListByClient(int uid) {
    return _providerAccount.getAccountListByClient(uid);
  }

  Future<APIResponse<Object>> startCollectingAccounts(List<CollectAccountModel> list, String status, int idReservation) {
    print('api_repository');
    return _providerAccount.startCollectingAccounts(list, status, idReservation);
  }  
  //--------------------- ORDER ---------------------------
  Future<APIResponse<Object>> setOrder(OrderModel order) {
    return _providerOrder.setOrder(order);
  }
  //--------------------- ORDER DISH---------------------------
  Future<APIResponse<bool>> setDishesOrder(List<OrderDishModel> dishes) {
    return _providerOrderDish.setDishesOrder(dishes);
  }
  //--------------------- BRANCH DISH---------------------------
  Future<APIResponse<Object>> getBranchDishesList(
      String idBranch, String idMenu) {
    return _providerBranchDish.getBranchDishesList(idBranch, idMenu);
  }
  //--------------------- CONTACT ---------------------------
  Future<APIResponse<Object>> getContactList(String uid) {
    return _providerContact.getContactList(uid);
  }
  Future<APIResponse<Object>> setContactList(List<ContactModel> list) {
    return _providerContact.setContactList(list);
  }
  Future<APIResponse<Object>> deleteContactList(List<ContactModel> list) {
    return _providerContact.deleteContactList(list);
  }
  //--------------------- RESERVATION---------------------------
  Future<APIResponse<Object>> setReservation(ReservationModel reservation) {
    return _providerReservation.postReservation(reservation);
  }
  Future<APIResponse<Object>> getReservation(String idReservation) {
    return _providerReservation.getReservation(idReservation);
  }
  Future<APIResponse<Object>> getActiveReservation(String uid) {
    return _providerReservation.getActiveReservation(uid);
  }
  Future<APIResponse<Object>> getFinishReservationList(String uid) {
    return _providerReservation.getFinishReservationList(uid);
  }
  Future<APIResponse<Object>> getOrdersActiveByReservation(String uid) {
    return _providerReservation.getOrdersActiveByReservation(uid);
  }
  Future<APIResponse<Object>> confirmReservation(ReservationModel reservation) {
    return _providerReservation.confirmReservation(reservation);
  }
  //--------------------- ORDER RESERVATION ---------------------------
  Future<APIResponse<Object>> getOrderReservationList(String uid) {
    return _providerOrderReservation.getOrderReservationList(uid);
  }
  //--------------------- NOTIFICATION ---------------------------
  Future<APIResponse<Object>> sendNotification(NotificationModel notification){
    return _providerNotification.sendNotification(notification);
  }
  //--------------------- TIP ---------------------------
  Future<APIResponse<Object>> getListTip(int idreservation){
    return _providerTip.getListTip(idreservation);
  }
  //--------------------- TAX ---------------------------
  Future<APIResponse<Object>> getTax(int idreservation){
    return _providerTax.getTax(idreservation);
  }
}

class NetworkError extends Error {}
