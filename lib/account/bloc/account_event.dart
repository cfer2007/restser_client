part of 'account_bloc.dart';

abstract class AccountEvent {
  const AccountEvent();
}

class SetAccountList extends AccountEvent {
  final List<AccountModel> list;
  SetAccountList(this.list);
}

class SetAccount extends AccountEvent {
  final AccountModel account;
  SetAccount(this.account);
}

class GetAccount extends AccountEvent {
  GetAccount();
}

class GetAccountList extends AccountEvent {
  final String idReservation;
  GetAccountList(this.idReservation);
}

class JoinAccount extends AccountEvent {
  final AccountModel account;
  JoinAccount(this.account);
}

class AddAccount extends AccountEvent {
  AccountModel account;
  AddAccount(this.account);
}

class DeleteAccount extends AccountEvent {
  int index;
  DeleteAccount(this.index);
}

class GetAccountListByClient extends AccountEvent {
  int uid;
  GetAccountListByClient(this.uid);
}

class CalculateTip extends AccountEvent {
  int percentage;
  int indexAccount;
  CalculateTip(this.percentage, this.indexAccount);
}

class ClearAccountBloc extends AccountEvent {}
