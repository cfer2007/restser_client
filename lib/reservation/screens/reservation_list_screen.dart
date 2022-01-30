import 'package:firebase_auth/firebase_auth.dart';
import '/order/bloc/order_bloc.dart';
import '/order/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationListScreen extends StatefulWidget {
  const ReservationListScreen({Key? key}) : super(key: key);

  @override
  _ReservationListScreenState createState() => _ReservationListScreenState();
}

class _ReservationListScreenState extends State<ReservationListScreen> {
  OrderBloc? _orderBloc;
  final List<OrderModel> _activeList = [];
  final List<OrderModel> _finishList = [];
  bool isLoadedFirstTime = true;
  Icon _icon = const Icon(Icons.arrow_drop_down_outlined);  
  var uid;

  @override
  initState() {
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    init();    
    super.initState();
  }

  Future init() async {
    uid = await FirebaseAuth.instance.currentUser!.uid;//await UserSecureStorage().getUid();
    _orderBloc!.add(GetOrderListByClient(uid: uid));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //drawer: SideMenuScreen(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom:
              const TabBar(tabs: [Tab(text: 'ACTIVAS'), Tab(text: 'FINALIZADAS')]),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
          title: const Center(child: Text('Reservaciones')),
        ),
        body: TabBarView(
          children: [
            _builListOrder(_activeList),
            _builListOrder(_finishList),
          ],
        ),
      ),
    );
  }

  Widget _builListOrder(List<OrderModel> list) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      if (state is OrderListLoading) {
        return _buildLoading();
      } else if (state is OrderListByClientLoaded) {
        if (isLoadedFirstTime) {
          for (var item in state.listOrder) {
            if (item.account!.reservation!.status == 'FINALIZADA') {
              _finishList.add(item);
            } else {
              _activeList.add(item);
            }
          }
          isLoadedFirstTime = false;
        }
        return _buildCard(context, list);
        //return _buildCard(context, state.listOrder);
      } else {
        return Container();
      }
    });
  }

  Widget _buildCard(BuildContext context, List<OrderModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ExpansionTile(
                leading: CircleAvatar(
                  radius: 23,
                  child: ClipOval(
                    child: Image.network(
                      list[index]
                          .account!
                          .reservation!
                          .table!
                          .branch!
                          .restaurant!
                          .logo
                          .toString(),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                    'RS${list[index].account!.reservation!.idReservation}-OR${list[index].idOrder}'),
                subtitle: Text(
                  'Estado: ${list[index].account!.reservation!.status.toString()} \n${list[index].date}',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
                onExpansionChanged: (value) {
                  setState(() {
                    value
                        ? _icon = const Icon(Icons.arrow_drop_up_outlined)
                        : _icon = const Icon(Icons.arrow_drop_down_outlined);
                  });
                },
                trailing: Wrap(
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                        'Total: ${list[index].listOrderDish![0].currency}.${list[index].totalPrice}'),
                    _icon,
                  ],
                ),
                children: <Widget>[
                  for (int i = 0; i < list[index].listOrderDish!.length; i++)
                    ListTile(
                      title:
                          Text('${list[index].listOrderDish![i].name}'),
                      subtitle: Text(
                          '${list[index].listOrderDish![i].units} x ${list[index].listOrderDish![i].currency}${list[index].listOrderDish![i].price}'),
                    )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
