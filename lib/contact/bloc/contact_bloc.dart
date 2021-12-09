import 'dart:async';

import '/contact/models/contact_model.dart';
import '/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ApiRepository _apiRepository = ApiRepository();
  ContactBloc() : super(ContactInitial());

  List<ContactModel> contactList = [];
  List<ContactModel> removeList = [];
  List<ContactModel> addList = [];

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    try {
      if (event is ClearContactBloc) {
        contactList = [];
        yield ContactInitial();
      }
      if (event is GetContactList) {
        {
          final contactList = await _apiRepository.getContactList(event.uid);
          if (contactList.error) {
            yield ContactError(contactList.errorMessage as String);
          } else {
            this.contactList = contactList.data as List<ContactModel>;
            if (event.isMultiAccount) {
              yield ContactListLoaded(contactList.data as List<ContactModel>);
            } else {
              yield FriendListLoaded(contactList.data as List<ContactModel>);
            }
          }
        }
      }
      if (event is AddContact) {
        contactList.add(event.contact);
        addList.add(event.contact);
        yield state.copyWith(contactList: contactList);
      }
      if (event is DeleteContact) {
        removeList.add(contactList[event.index]);

        for (var i = 0; i < addList.length; i++) {
          if (addList[i].email == contactList[event.index].email) {
            addList.removeAt(i);
          }
        }

        contactList.removeAt(event.index);

        /*print('contactList: ${contactList.length}');
        print('addList: ${addList.length}');
        print('removeList: ${removeList.length}');*/

        yield state.copyWith(contactList: contactList);
      }
      if (event is SetContactList) {
        if (addList.isNotEmpty) {
          final result = await _apiRepository.setContactList(addList);
          if (result.error) {
            yield ContactError(result.errorMessage as String);
          } else {
            addList = [];
          }
        }
        if (removeList.isNotEmpty) {
          final resultDelete =
              await _apiRepository.deleteContactList(removeList);
          if (resultDelete.error) {
            yield ContactError(resultDelete.errorMessage as String);
          } else {
            removeList = [];
          }
        }
        yield state.copyWith(setContactListStatus: true);
      }
      if (event is ChangeStatusBool) {
        yield state.copyWith(setContactListStatus: false);
      }
    } on NetworkError {
      yield ContactError('error contact_bloc');
    }
  }
}
