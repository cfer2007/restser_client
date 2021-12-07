part of 'account_bloc.dart';

class AccountState {
  List<AccountModel>? accountList = [];
  List<AccountModel>? accountReservationList = [];
  AccountModel? account;
  bool? setAccountListStatus = false;
  List<AccountModel>? accountListByClient = [];
  bool? setMainAccountStatus = false;

  AccountState({
    this.accountList,
    this.account,
    this.setAccountListStatus,
    this.accountReservationList,
    this.accountListByClient,
    this.setMainAccountStatus,
  });
  AccountState copyWith({
    List<AccountModel>? accountList,
    List<AccountModel>? accountReservationList,
    AccountModel? account,
    bool? setAccountListStatus,
    List<AccountModel>? accountListByClient,
    bool? setMainAccountStatus = false,
  }) {
    return AccountState(
      accountList: accountList ?? this.accountList,
      accountReservationList: accountReservationList ?? accountReservationList,
      account: account ?? this.account,
      setAccountListStatus: setAccountListStatus ?? this.setAccountListStatus,
      accountListByClient: accountListByClient ?? this.accountListByClient,
      setMainAccountStatus: setMainAccountStatus ?? this.setMainAccountStatus,
    );
  }
}

class AccountInitial extends AccountState {
  AccountInitial();
}

class AccountLoading extends AccountState {
  AccountLoading();
}

class SetAccountLoaded extends AccountState {
  final AccountModel account;
  SetAccountLoaded(this.account);
}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}
