import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restser_client/order_reservation/bloc/order_reservation_bloc.dart';
import 'package:restser_client/order_reservation/models/dishes_order_reservation_model.dart';
import 'package:restser_client/reservation/bloc/reservation_bloc.dart';
import 'package:restser_client/reservation/models/reservation_finish_model.dart';
import 'package:restser_client/reservation/widgets/tracking_reservation_widget.dart';
import 'package:restser_client/resources/api_resources.dart';

class ReservationTrackingScreen extends StatefulWidget {
  const ReservationTrackingScreen({Key? key}) : super(key: key);

  @override
  State<ReservationTrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<ReservationTrackingScreen> {  
  ReservationBloc? _reservationBloc;
  OrderReservationBloc? _orderReservationBloc;
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  bool floatingActionButtonVisible = false;

  @override
  void initState(){
    _orderReservationBloc = BlocProvider.of<OrderReservationBloc>(context);
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);    
    _reservationBloc!.add(GetActiveReservation(_uid));
    _orderReservationBloc!.add(GetOrderReservationList(FirebaseAuth.instance.currentUser!.uid));

    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationBloc, ReservationState>(
      listener: (context, state) async {
        if(state is ReservationOrdersActiveLoaded){
          if (state.reservationOrdersActive!.reservation!.idReservation != null){
            Navigator.of(context).pushNamed('/confirm_reservation_screen');
          }
        }
        else if(state is ReservationConfirmed){
          _orderReservationBloc!.add(GetOrderReservationList(_uid));
        }
      },
      //child: const TrackingReservationWidget(),
      child: _buildTrackingReservationView(),
    );
  }

  Widget _buildTrackingReservationView(){
    final _uid = FirebaseAuth.instance.currentUser!.uid;
    return DefaultTabController(      
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom:
            TabBar(
              onTap: (index) async {
                if(index == 1){
                  _reservationBloc!.add(GetReservationFinishedList(_uid));
                }
              },
              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                const Tab(text: 'ACTIVAS'), 
                const Tab(text: 'FINALIZADAS')
              ]
            ),
          actions: [
            IconButton(onPressed: () {}, 
            icon: const Icon(Icons.notifications))
          ],
          title: const Center(child: Text('Reservaciones')),
        ),
        body: TabBarView(
          children: [
            _buildListOrderReservationActive(),
            _buildReservationFinishedList()
          ],
        ),     
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,   
        floatingActionButton: Visibility(
          visible:  floatingActionButtonVisible,
          child: FloatingActionButton.extended(
            onPressed: (){
              //print(_orderReservationBloc!.state.dishesOrderReservationList![0].orderReservation!.idReservation);
              Navigator.of(context).pushNamed('/finish_reservation_screen', arguments: _orderReservationBloc!.state.dishesOrderReservationList![0].orderReservation!.idReservation);
            }, 
            label: const Text('Finalizar Reservacion'),
          ),
        ),
      ),
    );
  }

  Widget _buildListOrderReservationActive(){
    return BlocConsumer<OrderReservationBloc, OrderReservationState>(
      listener: (context, state){
        if(state is OrderReservationListLoaded){   
          int cont = 0;
          for (var item in state.dishesOrderReservationList!) {
            if(item.orderReservation!.status == OrderStatus.delivered.name){
              cont++;
            }
          }
          if((cont == state.dishesOrderReservationList!.length) && state.dishesOrderReservationList!.isNotEmpty) {
            setState(() {
              floatingActionButtonVisible = true;   
            });
          }
          else {
            setState(() {
              floatingActionButtonVisible = false;
            });
          }
        }
        
      },
      builder: (context, state){
        if(state is OrderReservationListLoaded){    
          return _buildCardOrdersActive(context, state.dishesOrderReservationList!);
        }
        else {
          return _buildLoading();
        }
      }
    );    
  }

  Widget _buildReservationFinishedList(){
    return BlocBuilder<ReservationBloc,ReservationState>(builder: (context,state){
      
      if(state is ReservationFinishedListLoaded){
        return _buildCardReservationFinished(context,state.reservationFinishedList!);
        
      } else {
        return _buildLoading();
      }
    });
  }

  Widget _buildCardOrdersActive(BuildContext context, List<DishesOrderReservationModel> orderReservationList) {
    if(orderReservationList.isNotEmpty){
      return ListView.builder(
        itemCount: orderReservationList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Estado de Orden'),
                
                for(int i=0;i<orderReservationList[index].orderReservation!.listOrderReservationDetail!.length;i++)
                  ListTile(
                    title: Text(orderReservationList[index].orderReservation!.listOrderReservationDetail![i].status!),
                    subtitle: Text(orderReservationList[index].orderReservation!.listOrderReservationDetail![i].date!),
                  ),
                ExpansionTile(
                  title: const Text('Detalle Orden'),
                  children: [
                    for(int j=0;j<orderReservationList[index].orderDishList!.length;j++)
                      ListTile(
                        title: Text('${orderReservationList[index].orderDishList![j].units} X ${orderReservationList[index].orderDishList![j].name!}'),
                        subtitle: Text('${orderReservationList[index].orderDishList![j].currency}${orderReservationList[index].orderDishList![j].price}'),
                      )
                  ],
                ),
              ],
            ),          
          );
        },
      );
    }
    else{
      return const Text('no hay data');
    }
  }

  Widget _buildCardReservationFinished(BuildContext context, List<ReservationFinishModel> reservation){
    if(reservation.isNotEmpty){
      return ListView.builder(
        itemCount: reservation.length,
        itemBuilder: (context, index){
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Reservation: ${reservation[index].idReservation}\n${reservation[index].start!}'),
              subtitle: Text('Subtotal: ${reservation[index].subtotal}'),
            ),
          );
        }
      );
    }
    else{
      return const Text('no hay data');
    }
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

}