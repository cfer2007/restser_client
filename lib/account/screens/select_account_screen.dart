import '/account/bloc/account_bloc.dart';
import '/account/models/account_model.dart';
import '/widgets/my_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAccountScreen extends StatefulWidget {
  const SelectAccountScreen({Key? key}) : super(key: key);

  @override
  _SelectAccountScreenState createState() => _SelectAccountScreenState();
}

class _SelectAccountScreenState extends State<SelectAccountScreen> {
  List<AccountModel> data = <AccountModel>[];
  String? selectedSpinnerItem;
  AccountBloc? _accountBloc;
  Future<List<AccountModel>>? myFuture;
  AccountModel? selectedAccount;

  Future<List<AccountModel>> getData() async {
    data = _accountBloc!.state.accountReservationList!;
    selectedSpinnerItem = data[0].user!.email;
    selectedAccount = data[0];
    return data;
  }

  @override
  void initState() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    myFuture = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AccountModel>>(
        future: myFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: MyAppBar(
              title: "Seleccionar Cuenta",
              context: context,
              leading: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 15,
                    ),
                    child: Text(
                        "Elija la cuenta a la que se cargaran sus ordenes"),
                  ),
                  DropdownButton<String>(
                    items: data.map((item) {
                      return DropdownMenuItem<String>(
                        child: Text(item.user!.email!),
                        value: item.user!.email,
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        selectedSpinnerItem = newVal;
                        selectedAccount = data[
                            data.indexWhere((tx) => tx.user!.email == newVal)];
                      });
                    },
                    value: selectedSpinnerItem,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
                label: const Text("Confirmar"),
                onPressed: () {
                  _accountBloc!.add(JoinAccount(selectedAccount!));
                  Navigator.of(context).pushNamed(
                    '/menu',
                  );
                }),
          );
        });
  }
}
