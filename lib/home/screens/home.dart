import 'package:restser_client/reservation/screens/confirm_reservation_screen.dart';
import 'package:restser_client/services/push_notifications_service.dart';

import '/account/screens/account_screen.dart';
import '/home/widgets/home_page.dart';
import '../../reservation/screens/reservation_list_screen.dart';
import '/home/widgets/restaurant_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final int index;
  Home({required this.index});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    const HomePage(),
    const RestauratPage(),
    const ReservationListScreen(),//ReservationListScreen(),
    //ContactScreen(),
    const AccountScreen(),
  ];

  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
    PushNotificationsService.messagesStream.listen((message) { 
      print(message);
      String? id;
      message.data.forEach((key, value) {
        if(key == 'id_reservation') {
          id=value;
          print('idReservation: $value');
        }
      });
      Navigator.of(context).pushNamed('/confirm_reservation_screen', arguments: id);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF262AAA),
      child: Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: "Inicio",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: "Catalogo",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: "Mis Ordenes",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Perfil",
            ),
          ],
          selectedFontSize: 15,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.yellow,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
