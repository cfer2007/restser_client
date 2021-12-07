import '/contact/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContactList extends StatefulWidget {
  final ContactBloc _contactBloc;
  ContactList(this._contactBloc);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget._contactBloc.state.contactList == null ||
                widget._contactBloc.state.contactList!.isEmpty
            ? 0
            : widget._contactBloc.state.contactList!.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 20,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: FittedBox(
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              title: Text(
                widget._contactBloc.state.contactList![index].username!,
                // ignore: deprecated_member_use
                //style: Theme.of(context).textTheme.title,
              ),
              subtitle:
                  Text(widget._contactBloc.state.contactList![index].email!),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => setState(
                    () => widget._contactBloc.add(DeleteContact(index))),
              ),
            ),
          );
        },
      ),
    );
  }
}
