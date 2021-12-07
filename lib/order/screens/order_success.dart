import '/account/bloc/account_bloc.dart';
import '/contact/bloc/contact_bloc.dart';
import '/order/bloc/order_bloc.dart';
import '/reservation/bloc/reservation_bloc.dart';
import '/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  /* @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(ClearOrderBloc());
    BlocProvider.of<AccountBloc>(context).add(ClearAccountBloc());
    BlocProvider.of<ContactBloc>(context).add(ClearContactBloc());
    BlocProvider.of<ReservationBloc>(context).add(ClearReservationBloc());
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      //drawer: SideMenuScreen(),
      appBar:
          MyAppBar(title: "Orden Ingresada", context: context, leading: false),
      body: Container(
          alignment: Alignment.center,
          child: Text('Orden ingresada con exito')),
    );*/
    return Scaffold(
      appBar: MyAppBar(title: "Orden", context: context, leading: false),
      body: Builder(builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 15,
                ),
                child: Text("Orden ingresada con exito"),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(35, 15, 35, 15))),
                onPressed: () {
                  BlocProvider.of<OrderBloc>(context).add(ClearOrderBloc());
                  BlocProvider.of<ContactBloc>(context).add(ClearContactBloc());
                  BlocProvider.of<ReservationBloc>(context)
                      .add(ClearReservationBloc());
                  const Duration(milliseconds: 1000);
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/menu", (Route<dynamic> route) => false);
                },
                label: const Text('Agregar otra orden'),
                icon: const Icon(Icons.add),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(50, 15, 50, 15))),
                onPressed: () {
                  BlocProvider.of<OrderBloc>(context).add(ClearOrderBloc());
                  BlocProvider.of<AccountBloc>(context).add(ClearAccountBloc());
                  BlocProvider.of<ContactBloc>(context).add(ClearContactBloc());
                  BlocProvider.of<ReservationBloc>(context)
                      .add(ClearReservationBloc());
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (Route<dynamic> route) => false,
                      arguments: 2);
                },
                label: const Text('Revisar orden'),
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        );
      }),
    );
  }
}
