part of 'contact_bloc.dart';

class ContactState {
  List<ContactModel>? contactList;

  bool? setContactListStatus = false;

  ContactState({
    this.contactList,
    this.setContactListStatus,
  });
  ContactState copyWith({
    List<ContactModel>? contactList,
    bool? setContactListStatus,
  }) {
    return ContactState(
      contactList: contactList ?? this.contactList,
      setContactListStatus: setContactListStatus ?? this.setContactListStatus,
    );
  }
}

class ContactInitial extends ContactState {
  ContactInitial();
}

class ContactLoading extends ContactState {
  ContactLoading();
}

class ContactListLoaded extends ContactState {
  List<ContactModel>? contactList;

  ContactListLoaded(this.contactList);
}

class FriendListLoaded extends ContactState {
  List<ContactModel>? contactList;
  FriendListLoaded(this.contactList);
}

class ContactError extends ContactState {
  String message;
  ContactError(this.message);
}
