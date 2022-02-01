import 'package:restser_client/reservation/bloc/reservation_bloc.dart';

//import '/account/bloc/account_bloc.dart';
import '/dish/bloc/dish_bloc.dart';
import '/dish/models/dish_model.dart';
import '/menu/bloc/menu_bloc.dart';
import '/order/bloc/order_bloc.dart';
import '../../order/models/order_dish_model.dart';
import '/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class DishListScreen extends StatefulWidget {
  int index;
  DishListScreen({Key? key, required this.index}) : super(key: key);

  @override
  _DishListScreenState createState() => _DishListScreenState();
}

class _DishListScreenState extends State<DishListScreen> {
  DishBloc? _dishBloc;
  MenuBloc? _menuBloc;
  ReservationBloc? _reservationBloc;
  OrderBloc? _orderBloc;
  List<OrderDishModel> dishes = <OrderDishModel>[];

  @override
  void initState() {
    _dishBloc = BlocProvider.of<DishBloc>(context);
    _menuBloc = BlocProvider.of<MenuBloc>(context);
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);
    _orderBloc = BlocProvider.of<OrderBloc>(context);

    _dishBloc!.add(GetDishList(
        _reservationBloc!.state.reservation!.table!.branch!.idBranch.toString(),
        _menuBloc!.state.menuList![widget.index].idMenu.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildListDish();
  }

  Widget _buildListDish() {
    return BlocBuilder<DishBloc, DishState>(
      builder: (context, state) {
        if (state is DishInitial) {
          return _buildLoading();
        } else if (state is DishLoading) {
          return _buildLoading();
        } else if (state is DishLoaded) {
          return _buildCard(context, state.dishList);
        } else if (state is DishError) {
          return Container();
        }
        return Container();
      },
    );
  }

  Widget _buildCard(BuildContext context, List<DishModel> dishes) {
    return BlocBuilder<OrderBloc, OrderState>(
      bloc: _orderBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: MyAppBar(title: "Platos", context: context, leading: true),
          body: ListView.builder(
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: ClipOval(
                      child: Image.network(
                        dishes[index].photo!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(dishes[index].name!),
                  subtitle: Text(dishes[index].description!),
                  onTap: () {},
                  trailing: Wrap(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          _orderBloc!.add(
                            AddToOrder(
                              dish: OrderDishModel(
                                idDish: dishes[index].idDish!,
                                name: dishes[index].name!,
                                currency: dishes[index].currency!,
                                price: dishes[index].price!,
                                units: 1,
                              ),
                            ),
                          );
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
              icon: const Icon(Icons.shopping_basket),
              label: Text(_orderBloc!.count.toString()),
              backgroundColor: Colors.blue.shade400,
              onPressed: () {
                _orderBloc!.count == 0
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('La carreta esta vacia'),
                          duration: Duration(milliseconds: 500),
                          backgroundColor: Colors.red,
                        ),
                      )
                    : Navigator.of(context).pushNamed(
                        '/order',
                      );
              }),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
