part of 'contact_bloc.dart';

abstract class ContactEvent {
  const ContactEvent();
}

class GetContactList extends ContactEvent {
  String uid;
  bool isMultiAccount;
  GetContactList(this.uid, this.isMultiAccount);
}

class AddContact extends ContactEvent {
  ContactModel contact;
  AddContact(this.contact);
}

class DeleteContact extends ContactEvent {
  int index;
  DeleteContact(this.index);
}

class SetContactList extends ContactEvent {
  SetContactList();
}

class ClearContactBloc extends ContactEvent {}

class ChangeStatusBool extends ContactEvent {}
