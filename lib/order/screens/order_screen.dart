import 'package:restser_client/reservation/bloc/reservation_bloc.dart';
import 'package:restser_client/reservation/widgets/reservation_arguments.dart';
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
  @override
  Widget build(BuildContext context) {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);
    return BlocConsumer<OrderBloc, OrderState>(
      bloc: _orderBloc,
      listener: (context, state) {
        if (state.setDishesStatus != null && state.setDishesStatus == true) {
          if(_accountBloc!.state.account!.user!.uid == _reservationBloc!.state.reservation!.user!.uid){
            Navigator.of(context).pushNamed('/confirm_reservation_screen', arguments: _reservationBloc!.state.reservation!.idReservation!.toString());
          }
          else{
            Map<String, String> map = {
              'id_reservation': _reservationBloc!.state.reservation!.idReservation!.toString(),
              'action': 'order_setted',
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
              label: Text('Ordenar: ' + '${state.total}'),
              onPressed: () {
                state.dishes!.isNotEmpty
                    ? BlocProvider.of<OrderBloc>(context).add(SetOrder(
                        order: OrderModel(
                        account: _accountBloc!.state.account,
                        description: 'desc',
                        status: OrderStatus.started.name,
                        date: APIResources.dateFormat.format(DateTime.now()),
                        totalPrice: state.total,
                        totalUnits: state.count,
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
