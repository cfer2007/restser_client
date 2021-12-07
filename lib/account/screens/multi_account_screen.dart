// ignore_for_file: unnecessary_new

import '/account/bloc/account_bloc.dart';
import '/account/models/account_model.dart';
import '/contact/models/contact_model.dart';
import '/account/widgets/account_list.dart';
import '/contact/bloc/contact_bloc.dart';
import '/user/models/user_model.dart';
import '/reservation/models/reservation_model.dart';
import '/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiAccountScreen extends StatefulWidget {
  const MultiAccountScreen({Key? key}) : super(key: key);

  @override
  _MultiAccountScreenState createState() => _MultiAccountScreenState();
}

class _MultiAccountScreenState extends State<MultiAccountScreen> {
  List<ContactModel> data = <ContactModel>[];
  String? selectedSpinnerItem;
  AccountBloc? _accountBloc;
  ContactBloc? _contactBloc;
  Future<List<ContactModel>>? myFuture;

  Future<List<ContactModel>> getData() async {
    data = _contactBloc!.state.contactList!;
    selectedSpinnerItem = data[0].username;
    return data;
  }

  @override
  void initState() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _contactBloc = BlocProvider.of<ContactBloc>(context);
    myFuture = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state.setAccountListStatus != null &&
            state.setAccountListStatus == true) {
          Navigator.of(context).pushNamed(
            '/menu',
          );
        }
        if (state is AccountError) print(state.message);
      },
      builder: (context, state) {
        return FutureBuilder<List<ContactModel>>(
          future: myFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) const Center(child: CircularProgressIndicator());
            return Scaffold(
              appBar: MyAppBar(
                title: "Multi Cuentas",
                context: context,
                leading: true,
              ),
              body: Center(
                child: Column(
                  children: [
                    DropdownButton<String>(
                      items: data.map((item) {
                        return DropdownMenuItem<String>(
                          child: Text(item.username!),
                          value: item.username,
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        selectedSpinnerItem = newVal;
                        final account = new AccountModel(
                          user: new UserModel(
                              idUser: data[data.indexWhere(
                                      (tx) => tx.username == newVal)]
                                  .idFriend!,
                              name: newVal!,
                              email: data[data.indexWhere(
                                      (tx) => tx.username == newVal)]
                                  .email!),
                          reservation: new ReservationModel(
                              idReservation: _accountBloc!
                                  .state.account!.reservation!.idReservation),
                        );
                        _accountBloc!.add(AddAccount(account));
                      },
                      value: selectedSpinnerItem,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    AccountList(_accountBloc!),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                label: const Text("Guardar"),
                onPressed: () {
                  _accountBloc!.add(SetAccountList(_accountBloc!.accountList));
                },
              ),
            );
          },
        );
      },
    );
  }
}
