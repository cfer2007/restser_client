import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restser_client/order_reservation/bloc/order_reservation_bloc.dart';
import 'package:restser_client/reservation/bloc/reservation_bloc.dart';
import 'package:restser_client/reservation/widgets/tracking_reservation_widget.dart';

class ReservationTrackingScreen extends StatefulWidget {
  const ReservationTrackingScreen({Key? key}) : super(key: key);

  @override
  State<ReservationTrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<ReservationTrackingScreen> {
  
  ReservationBloc? _reservationBloc;
  OrderReservationBloc? _orderReservationBloc;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState(){
    _orderReservationBloc = BlocProvider.of<OrderReservationBloc>(context);
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);
    
    _reservationBloc!.add(GetActiveReservation(_uid));
    _orderReservationBloc!.add(GetOrderReservationList(_uid));
    
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationBloc, ReservationState>(
          listener: (context, state) {
            if(state is ReservationOrdersActiveLoaded){
              if (state.reservationOrdersActive!.idReservation != 0){
                Navigator.of(context).pushNamed('/confirm_reservation_screen');
              }
            }
            else if(state is ReservationConfirmed){
              _orderReservationBloc!.add(GetOrderReservationList(_uid));
            }
          },
          child: TrackingReservationWidget(_reservationBloc, _orderReservationBloc),
        );
  }
}