import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restser_client/order/models/order_dish_model.dart';
import 'package:restser_client/order/models/order_model.dart';
import 'package:restser_client/reservation/bloc/reservation_bloc.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/widgets/my_appbar.dart';

class ReservationOrderList extends StatefulWidget {
  const ReservationOrderList({Key? key}) : super(key: key);

  @override
  _ReservationOrderListState createState() => _ReservationOrderListState();
}

class _ReservationOrderListState extends State<ReservationOrderList> {
  ReservationBloc? _reservationBloc;
  int count = 0;
  bool loaded=false;
  bool confirmed = false;
  
  @override
  void initState(){
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);
    _reservationBloc!.add(GetReservationAll(3 /*_reservationBloc!.state.reservation!.idReservation.toString()*/));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Lista de Ordenes", context: context, leading: true),
      body: _buildListOrders(),
      floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              label: const Text('Confirmar Ordenes'),
              onPressed: () {
                confirmed = true;
                _reservationBloc!.state.reservation!.status =   ReservationStatus.confirmed.name;             
                _reservationBloc!.add(ConfirmReservation(_reservationBloc!.state.reservation!));
                
              }),
    );
        
  }
  Widget _buildListOrders() {
    
    return BlocConsumer<ReservationBloc, ReservationState>(
      listener: (context, state) {
        if(state is ReservationConfirmed){
          print('confirmed');
          Container();
        }
      },      
      buildWhen: (ReservationLoading,ReservationLoaded){
        if(_reservationBloc!.state.reservation !=null) {
          count = _reservationBloc!.state.reservation!.listAccount!.length;
        }
        return loaded = true;
      },
      builder: (context, state) {
        if(loaded==true && confirmed == false) {
          return _buildCard(context);          
        }else if(confirmed==true){
          return Container(child: Text('data'),);
        } 
        else {
          return _buildLoading();
        }
      },
    );    
  }

  Widget _buildCard(BuildContext context){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, i) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ExpansionTile(
                title: Text('${_reservationBloc?.state.reservation!.listAccount![i].user!.email} - ${_reservationBloc?.state.reservation!.listAccount![i].subtotal}'),
                children: [
                  for (int j = 0; j < _reservationBloc!.state.reservation!.listAccount![i].listOrder!.length; j++)
                    _buildOrder(_reservationBloc!.state.reservation!.listAccount![i].listOrder![j], i,j),
                  Text('Total -> ${ _reservationBloc!.state.reservation!.listAccount![i].subtotal.toString()}'),
                  Text(''),
                ],
              )
            ],
          ),
        );
      }
    );    
  }
  Widget _buildOrder(OrderModel order, int indexAccount, int indexOrder){
    return Column(
      children: [
        for (int k = 0; k < order.listOrderDish!.length; k++)   
          _buildDish(order.listOrderDish![k], indexAccount, indexOrder, k),             
      ],
    );
  }

  Widget _buildDish(OrderDishModel dish, int indexAccount, int indexOrder, int indexDish){
    return ListTile(
      title:Text(dish.name.toString()),
      subtitle: Text('${dish.price}x${dish.units}'),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            color: Colors.black,
            onPressed: () {              
              if(dish.units! > 0){
                _reservationBloc?.add(Decrement(indexAccount: indexAccount,  indexOrder: indexOrder, indexDish: indexDish)); 
              }
            },
          ),
          Text(dish.units.toString()),
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.black,
            onPressed: () {    
              _reservationBloc?.add(Increment(indexAccount: indexAccount,  indexOrder: indexOrder, indexDish: indexDish));                                                                     
            },
          ),
        ],
      ),                        
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}