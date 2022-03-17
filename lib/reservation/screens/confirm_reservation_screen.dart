import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restser_client/account/models/account_model.dart';
import 'package:restser_client/order/models/order_dish_model.dart';
import 'package:restser_client/reservation/bloc/reservation_bloc.dart';
import 'package:restser_client/reservation/models/reservation_model.dart';
import 'package:restser_client/resources/api_resources.dart';
import 'package:restser_client/widgets/my_appbar.dart';

class ConfirmReservationScreen extends StatefulWidget {
  const ConfirmReservationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmReservationScreen> createState() => _ConfirmReservationScreenState();
}

class _ConfirmReservationScreenState extends State<ConfirmReservationScreen> {
  ReservationBloc? _reservationBloc;
  
  @override
  void initState(){
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Ordenes por Confirmar", context: context, leading: true),
      body: _buildListOrders(),
      floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              label: const Text('Confirmar Ordenes'),
              onPressed: () { 
                ReservationModel res = ReservationModel();
                res.idReservation = _reservationBloc!.state.reservationOrdersActive!.reservation!.idReservation;
                res.status = ReservationStatus.confirmed.name;
                res.listAccount = _reservationBloc!.state.reservationOrdersActive!.listAccount;
  

                _reservationBloc!.add(ConfirmReservation(res));
                Navigator.pop(context);

              }),
    );
  }
  Widget _buildListOrders() {
    return BlocListener<ReservationBloc,ReservationState>(
     listener: (context,state){
      if(state is ReservationLoading){
        _buildLoading();
      }
     },
     child: _buildReservationCard(),
    );    
  }

  Widget _buildReservationCard(){
    return Column(
        children: [
          Text('Reservation: ${_reservationBloc!.state.reservationOrdersActive!.reservation!.idReservation}'),
          _buildAccountCard(_reservationBloc!.state.reservationOrdersActive!.listAccount!)
        ],    
      
      );
  }
  Widget _buildAccountCard(List<AccountModel> listAccount){
    return Column(
      children: [
        
        for(int j=0; j<listAccount.length; j++)
          ExpansionTile(    
            title: Text(listAccount[j].user!.email!),        
            children: [
              
              for(int k=0; k< listAccount[j].listOrder!.length; k ++)
              Column(
                children: [
                  for(int l = 0; l < listAccount[j].listOrder![k].listOrderDish!.length; l++)
                    _buildDish(listAccount[j].listOrder![k].listOrderDish![l], j, k , l),
                ],
              )
            ],
          ) 
      ],
    );    
  }

  Widget _buildDish(OrderDishModel dish, int indexAccount, int indexOrder, int indexDish){
    return ListTile(
      title:Text(dish.name.toString()),
      subtitle: Text('${dish.currency}${dish.price}x${dish.units}'),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            color: Colors.black,
            onPressed: () {   
              setState(() {
                if(dish.units! > 0){
                _reservationBloc?.add(DecrementUnits(indexAccount: indexAccount, indexOrder: indexOrder, indexDish: indexDish));
              }
              });
              
            },
          ),
          Text(dish.units.toString()),
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.black,
            onPressed: () {    
              setState(() {
                _reservationBloc?.add(IncrementUnits(indexAccount: indexAccount, indexOrder: indexOrder, indexDish: indexDish));   
              });                                                                       
            },
          ),
        ],
      ),                        
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}