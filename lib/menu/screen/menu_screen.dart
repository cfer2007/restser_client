import 'package:restser_client/reservation/bloc/reservation_bloc.dart';

import '/menu/bloc/menu_bloc.dart';
import '/menu/model/menu_model.dart';
import '/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  MenuBloc? _menuBloc;
  ReservationBloc? _reservationBloc;
  bool loaded = false;

  @override
  void initState() {
    _menuBloc = BlocProvider.of<MenuBloc>(context);
    _reservationBloc = BlocProvider.of<ReservationBloc>(context);
    print(_reservationBloc?.state.reservation!.table!.branch!.restaurant!.idRestaurant!);
    _menuBloc!.add(
      GetMenuList(
        _reservationBloc!.state.reservation!.table!.branch!.restaurant!.idRestaurant!,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Menu", context: context, leading: true),
      body: _buildListMenu(),
    );
  }

  Widget _buildListMenu() {
    return BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
      if (state is MenuInitial) {
        return _buildLoading();
      } else if (state is MenuLoading) {
        return _buildLoading();
      } else if (state is MenuListLoaded) {
        return _buildCard(context, state.menuList);
      } else if (state is MenuError) {
        return Container();
      } else {
        return Container();
      }
    });
  }

  Widget _buildCard(BuildContext context, List<MenuModel> menu) {
    return ListView.builder(
      itemCount: menu.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: ClipOval(
                child: Image.network(
                  menu[index].photo!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(menu[index].category!),
            subtitle: Text(menu[index].description!),
            onTap: () {
              Navigator.of(context).pushNamed('/dish_list', arguments: index);
            },
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
