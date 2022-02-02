// ignore_for_file: unnecessary_new

import 'package:restser_client/reservation/bloc/reservation_bloc.dart';
import 'package:restser_client/resources/api_repository.dart';
import 'package:restser_client/services/notification_model.dart';

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
  ReservationBloc? _reservationBloc;
  Future<List<ContactModel>>? myFuture;

  final ApiRepository _apiRepository = ApiRepository();

  Future<List<ContactModel>> getData() async {
    data = _contactBloc!.state.contactList!;
    selectedSpinnerItem = data[0].username;
    return data;
  }

  @override
  void initState() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);
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
          Navigator.of(context).pushNamed('/menu', arguments: _reservationBloc!.state.reservation!.table!.branch!.restaurant!.idRestaurant.toString());
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
                              uid: data[data.indexWhere(
                                      (tx) => tx.username == newVal)]
                                  .idFriend!,
                              name: newVal!,
                              email: data[data.indexWhere(
                                      (tx) => tx.username == newVal)]
                                  .email!),
                          reservation: new ReservationModel(
                              idReservation: _reservationBloc!
                                  .state.reservation!.idReservation),
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
                  //crear alerta para consultar si desea enviar notificacion de la reservacion a los usuarios agregados
                    //{
                    _accountBloc!.accountList.forEach((element) { 
                      print('idRestaurante: ${_reservationBloc!.state.reservation!.table!.branch!.restaurant!.idRestaurant.toString()}');
                      
                      Map<String, String> map = {
                        'action': 'RESERVATION_SETTED',
                        'id': '1',//_reservationBloc!.state.reservation!.table!.branch!.restaurant!.idRestaurant.toString(),              
                      };
                      print('${element.user!.uid } -- ${element.user!.email}');
                      _apiRepository.sendNotification(
                        NotificationModel(
                          uid: element.user!.uid,
                          title: "Invitacion a Reservacion",
                          message: "El usuario ${_accountBloc!.state.account!.user!.email} te ha agregado a una reservacion para que puedas agregar ordenes",
                          data: map,
                        )
                      );  
                    });
                    
                    //}
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
