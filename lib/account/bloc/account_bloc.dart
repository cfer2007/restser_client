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

    } catch (e) {
      print('error: account_bloc');
    }
  }

  Stream<AccountState> _calculeteTip(int percentage, int indexAccount) async* {
    print('_calculeteTip');

    state.accountReservationList![indexAccount].tipPercentage = percentage;

    state.accountReservationList![indexAccount].tip 
    = double.parse(((state.accountReservationList![indexAccount].subtotal! + state.accountReservationList![indexAccount].tax!) 
    * (percentage/100)).toStringAsFixed(2));

    state.accountReservationList![indexAccount].total 
    = state.accountReservationList![indexAccount].subtotal! 
    + state.accountReservationList![indexAccount].tax!
    + state.accountReservationList![indexAccount].tip!;

    print(state.accountReservationList![indexAccount].tip);

    yield state.copyWith(accountReservationList: state.accountReservationList!);
    yield GetAccountReservationListLoaded(state.accountReservationList!);
  }
}
