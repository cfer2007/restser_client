import 'package:restser_client/contact/bloc/contact_bloc.dart';
import 'package:restser_client/reservation/bloc/reservation_bloc.dart';
import 'package:restser_client/resources/api_repository.dart';
import 'package:restser_client/services/notification_model.dart';

import '/account/bloc/account_bloc.dart';
import '/order/bloc/order_bloc.dart';
import '/order/models/order_model.dart';
import '/resources/api_resources.dart';
import '/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderBloc? _orderBloc;
  AccountBloc? _accountBloc;
  ReservationBloc? _reservationBloc;
  final ApiRepository _apiRepository = ApiRepository();
  String? currency;

  @override
  Widget build(BuildContext context) {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);
    return BlocConsumer<OrderBloc, OrderState>(
      bloc: _orderBloc,
      listener: (context, state) {
        if (state.setDishesStatus != null && state.setDishesStatus == true) {
          print(_accountBloc!.state.account!.user!.uid);
          print(_reservationBloc!.state.reservation!.user!.uid);
          if(_accountBloc!.state.account!.user!.uid == _reservationBloc!.state.reservation!.user!.uid){
            
            BlocProvider.of<OrderBloc>(context).add(ClearOrderBloc());
            BlocProvider.of<AccountBloc>(context).add(ClearAccountBloc());
            BlocProvider.of<ContactBloc>(context).add(ClearContactBloc());
            BlocProvider.of<ReservationBloc>(context).add(ClearReservationBloc());
            Navigator.pushNamedAndRemoveUntil(context, "/home", (Route<dynamic> route) => false,arguments: 2);
          }
          else{
            Map<String, String> map = {
              'action': 'ORDER_SETTED',
              'id': _reservationBloc!.state.reservation!.idReservation!.toString(),              
            };
            _apiRepository.sendNotification(
              NotificationModel(
                uid: _reservationBloc!.state.reservation!.user!.uid,
                title: "orden ingresada",
                message: "El usuario ${_accountBloc!.state.account!.user!.email} ha ingresado una nueva orden a su reservacion",
                data: map,
              )
            );
            Navigator.of(context).pushNamed('/order_success');
          }
          
        }
        //_alert('Exito', 'La orden fue ingresada con exito', Colors.green);
        if (state is OrderError) {
          _alert(
              'Error',
              'Vaya ha ocurrido un error, deseas volver a intentarlo?',
              Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: MyAppBar(title: "Orden", context: context, leading: true),
          body: ListView.builder(
            itemCount: state.dishes == null ? 0 : state.dishes!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(state.dishes![index].name!),
                  subtitle: Text(
                      '${state.dishes![index].currency}${state.dishes![index].price.toString()}'),
                  onTap: () {},
                  trailing: Wrap(
                    spacing: -10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.remove),
                        color: Colors.black,
                        onPressed: () {
                          _orderBloc!.add(Decrement(index: index));
                        },
                      ),
                      Text(state.dishes![index].units.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.black,
                        onPressed: () {
                          _orderBloc!.add(Increment(index: index));
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          
                          _orderBloc!.add(DelFromOrder(index: index));
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              label: Text('Ordenar: ${state.total}'),
              onPressed: () {
                currency = state.dishes![0].currency;
                state.dishes!.isNotEmpty
                    ? BlocProvider.of<OrderBloc>(context).add(SetOrder(
                        order: OrderModel(
                        account: _accountBloc!.state.account,
                        description: 'desc',
                        //status: OrderStatus.started.name,
                        date: APIResources.dateFormat.format(DateTime.now()),
                        totalPrice: state.total,
                        totalUnits: state.count,
                        currency: currency,
                      )))
                    : BlocProvider.of<OrderBloc>(context).add(
                        SetOrderError('No hay platos para agregar a la orden'));
              }),
        );
      },
    );
  }

  _alert(String title, String content, Color color) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: color,
          ),
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              title.toLowerCase() == 'error'
                  ? Navigator.pop(context, 'Ok')
                  : Navigator.of(context).pushReplacementNamed(
                      '/home',
                      arguments: 2,
                    )
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
