import '/widgets/my_appbar.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter/material.dart';

class RestauratPage extends StatelessWidget {
  const RestauratPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: SideMenuScreen(),
      appBar: MyAppBar(title: "Restaurantes", context: context, leading: false),
      body: Container(child: const Text('Restaurantes'),),
    );
  }
}