import 'dart:async';
import '/account/models/account_model.dart';
import '/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final ApiRepository _apiRepository = ApiRepository();
  AccountBloc() : super(AccountInitial());

  List<AccountModel> accountList = [];
  //AccountModel account;

  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    try {
      if (event is ClearAccountBloc) {
        accountList = [];
        yield AccountInitial();
      }
      if (event is SetAccount) {
        final result = await _apiRepository.setAccount(event.account);
        if (result.error) {
          yield AccountError(result.errorMessage as String);
        } else {
          state.copyWith(setMainAccountStatus: true);
        }
        yield SetAccountLoaded(result.data as AccountModel);
      }
      if (event is SetAccountList) {
        final result = await _apiRepository.setAccountList(event.list);
        if (result.error) {
          yield AccountError(result.errorMessage as String);
        } else {
          yield state.copyWith(setAccountListStatus: true);
        }
      }
      if (event is JoinAccount) {
        yield state.copyWith(account: event.account);
      }
      if (event is AddAccount) {
        accountList.add(event.account);
        yield state.copyWith(accountList: accountList);
      }
      if (event is DeleteAccount) {
        accountList.removeAt(event.index);
        yield state.copyWith(accountList: accountList);
      }
      if (event is GetAccountList) {
        final result = await _apiRepository.getAccountList(event.idReservation);
        if (result.error) {
          yield AccountError(result.errorMessage as String);
        } else {
          yield state.copyWith(
              accountReservationList: result.data as List<AccountModel>);
        }
      }
      if (event is GetAccountListByClient) {
        final res = await _apiRepository.getAccountListByClient(event.uid);
        if (res.error) {
          yield AccountError(res.errorMessage as String);
        } else {
          yield state
              .copyWith(accountListByClient: res.data as List<AccountModel>);
        }
      }
    } catch (e) {
      print('error: account_bloc');
    }
  }
}
