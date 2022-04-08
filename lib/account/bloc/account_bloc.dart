import 'dart:async';
import 'package:restser_client/account/models/collect_account_model.dart';

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

  @override
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
          state.copyWith(accountReservationList: result.data as List<AccountModel>);
          yield GetAccountReservationListLoaded(result.data as List<AccountModel>);
        }
      }

      if (event is GetCollectAccountList) {
        final result = await _apiRepository.getCollectAccountList(event.idReservation);
        if (result.error) {
          yield AccountError(result.errorMessage as String);
        } else {
          state.copyWith(collectAccountList: result.data as List<CollectAccountModel>);
          yield CollectAccountListLoaded(result.data as List<CollectAccountModel>);
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
      if (event is CalculateTip) {
        yield* _calculeteTip(event.percentage, event.indexAccount);
      }

      if(event is StartCollectingAccounts){
        print('StartCollectingAccounts');
        final result = await _apiRepository.startCollectingAccounts(state.collectAccountList!, event.status, event.idReservation);
        if (result.error) {
          yield AccountError(result.errorMessage as String);
        } else {
          StartCollectingAccountsLoaded();
        }
      }

    } catch (e) {
      print('error: account_bloc');
    }
  }

  Stream<AccountState> _calculeteTip(int percentage, int indexAccount) async* {
    print('_calculeteTip');

    state.collectAccountList![indexAccount].tipPercentage = percentage;

    state.collectAccountList![indexAccount].tip 
    = double.parse(((state.collectAccountList![indexAccount].subtotal! + state.collectAccountList![indexAccount].tax!) 
    * (percentage/100)).toStringAsFixed(2));

    state.collectAccountList![indexAccount].total 
    = state.collectAccountList![indexAccount].subtotal! 
    + state.collectAccountList![indexAccount].tax!
    + state.collectAccountList![indexAccount].tip!;

    print(state.collectAccountList![indexAccount].tip);

    yield state.copyWith(collectAccountList: state.collectAccountList!);
    yield CollectAccountListLoaded(state.collectAccountList!);
  }
}
