import 'package:restser_client/login/widgets/user_secure_storage.dart';

import '/account/bloc/account_bloc.dart';
import '/account/models/account_model.dart';
import '/user/models/user_model.dart';
import '/login/bloc/login_bloc.dart';
import '/reservation/bloc/reservation_bloc.dart';
import '/reservation/models/reservation_model.dart';
import '/reservation/widgets/reservation_arguments.dart';
import '/reservation/widgets/textfield_code.dart';
import '/resources/api_resources.dart';
import '/table/bloc/table_bloc.dart';
import '/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationScreen extends StatefulWidget {
  final ReservationArguments arguments;

  const ReservationScreen({Key? key, 
    required this.arguments,
  }) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  TextEditingController codeController = TextEditingController();
  bool txtIsEmpty = false;
  ReservationBloc? _reservationBloc;
  TableBloc? _tableBloc;
  AccountBloc? _accountBloc;

  bool validateTextField(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        txtIsEmpty = true;
      });
      return false;
    }
    setState(() {
      txtIsEmpty = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);
    _tableBloc = BlocProvider.of<TableBloc>(context);
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    BlocProvider.of<ReservationBloc>(context).add(ClearReservationBloc());
    BlocProvider.of<AccountBloc>(context).add(ClearAccountBloc());
    return Scaffold(
      appBar: MyAppBar(
          title: widget.arguments.title, context: context, leading: false),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return MultiBlocListener(
      listeners: [
        BlocListener<TableBloc, TableState>(
          bloc: _tableBloc,
          listener: (context, state) {
            if (state is TableLoaded) {
              newAlert(context, state);
            } else if (state is TableError) {
              errorAlert("El código no es valido");
            }
          },
        ),
        BlocListener<ReservationBloc, ReservationState>(
          bloc: _reservationBloc,
          listener: (context, state) {
            if (state is ReservationLoaded) {
              joinAlert(context, state);
            } else if (state is ReservationSetted) {
              _accountBloc!.add(SetAccount(AccountModel(
                  reservation: state.reservation,
                  user:
                      UserModel(uid: state.reservation.user!.uid))));
            } else if (state is ReservationError) {
              errorAlert("La Reservacion no es valida");
            }
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          bloc: _accountBloc,
          listener: (context, state) {
            if (state is SetAccountLoaded) {
              Navigator.of(context).pushReplacementNamed('/type_account');
            } else if (state is AccountError) {
              print(state.message);
            }
          },
        )
      ],
      child: _screen(),
    );
  }

  Widget _screen() {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60.0,
            vertical: 15,
          ),
          child: Text(widget.arguments.description),
        ),
        TextFieldCode(
          codeController: codeController,
          txtIsEmpty: txtIsEmpty,
          labelText: widget.arguments.txtFieldLabel,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(35, 10, 40, 10),
            ),
          ),
          onPressed: () {
            validateTextField(codeController.text);
            if (codeController.text.isNotEmpty) {
              widget.arguments.isNewReservation == true
                  ? _tableBloc!.add(GetTable(codeController.text))
                  : _reservationBloc!
                      .add(GetReservation(codeController.text));
            }
          },
          icon: widget.arguments.codeBtnIcon,
          label: Text(widget.arguments.txtCodeBtn),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(20, 10, 20, 10),
            ),
          ),
          onPressed: () {},
          icon: widget.arguments.qrBtnIcon,
          label: Text(widget.arguments.txtQrBtn),
        ),
      ],
    );
  }

  Future<String?> newAlert(BuildContext context, TableLoaded state) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Reservacion'),
        content: Text(
          'Restaurante: ${state.tableModel.branch!.restaurant!.name}'
          '\nSucursal: ${state.tableModel.branch!.name}'
          '\nMesa para ${state.tableModel.size}',
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              var uid =await UserSecureStorage().getUid();
              var email =await UserSecureStorage().getEmail();

              final cli = UserModel(
                uid: uid,
                name: email,
                email: email,
              );
              final res = ReservationModel(
                user: cli,
                table: state.tableModel,
                status: 'INICIO',
                start: APIResources.dateFormat.format(DateTime.now()),
              );
              _reservationBloc!.add(SetReservation(res));
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Future<String?> joinAlert(
      BuildContext context, ReservationLoaded state) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Reservacion'),
        content: Text(
          'Id de reservacion: ${state.reservation.idReservation}'
          '\nRestaurante: ${state.reservation.table!.branch!.restaurant!.name}'
          '\nSucursal: ${state.reservation.table!.branch!.name}'
          '\nMesa para ${state.reservation.table!.size}'
          '\nReservado por: ${state.reservation.user!.email}',
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'CANCEL'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _accountBloc!.add(
                  GetAccountList(state.reservation.idReservation.toString()));
              Future.delayed(const Duration(milliseconds: 100), () {
                Navigator.of(context).pushReplacementNamed('/select_account');
              });
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  errorAlert(String content) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Ok'),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
