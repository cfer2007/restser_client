import '/account/bloc/account_bloc.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AccountList extends StatelessWidget {
  final AccountBloc _accountBloc;
  AccountList(this._accountBloc);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _accountBloc.state.accountList == null ||
                _accountBloc.state.accountList!.isEmpty
            ? 0
            : _accountBloc.state.accountList!.length,
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
                _accountBloc.state.accountList![index].user!.name!,
                // ignore: deprecated_member_use
                //style: Theme.of(context).textTheme.title,
              ),
              subtitle:
                  Text(_accountBloc.state.accountList![index].user!.email!),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => _accountBloc.add(DeleteAccount(index)),
              ),
            ),
          );
        },
      ),
    );
  }
}
