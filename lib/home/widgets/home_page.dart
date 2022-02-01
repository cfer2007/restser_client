import 'package:restser_client/reservation/widgets/reservation_arguments.dart';
import 'package:restser_client/services/push_notifications_service.dart';
import '/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /*@override
  void initState() {
    super.initState();

    PushNotificationsService.messagesStream.listen((message) { 
      //message.
      print(message.notification!.body);
      //Navigator.of(context).pushNamed('/account_screen');
    });
      
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Inicio", context: context, leading: true),
      body: Container(
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenid@",
              style: const TextStyle(fontSize: 25),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 15,
              ),
              child: Text(
                  "Puede unirse ó crear una reservación con las siguientes opciones:"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(50, 15, 50, 15))),
              onPressed: () {
                ReservationArguments arguments = ReservationArguments(
                  title: "Unirse a Reservación",
                  description:
                      "Para unirse a una reservación debe ingresar o escanear el código de reservación",
                  txtFieldLabel: "Cod. Reservación",
                  txtCodeBtn: "Buscar",
                  txtQrBtn: "Escanear QR",
                  codeBtnIcon: const Icon(Icons.search),
                  qrBtnIcon: const Icon(Icons.qr_code),
                  isNewReservation: false,
                );
                Navigator.of(context).pushReplacementNamed(
                    '/reservation_screen',
                    arguments: arguments);
              },
              label: const Text('Unirse'),
              icon: const Icon(Icons.person_add),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(50, 15, 50, 15))),
              onPressed: () {
                ReservationArguments arguments = ReservationArguments(
                  title: "Nueva Reservación",
                  description:
                      "Para crear una nueva reservación debe escanear o ingresar el código de la mesa",
                  txtFieldLabel: "Código de Mesa",
                  txtCodeBtn: "Crear",
                  txtQrBtn: "Escanear QR",
                  codeBtnIcon: const Icon(Icons.add),
                  qrBtnIcon: const Icon(Icons.qr_code),
                  isNewReservation: true,
                );
                Navigator.of(context).pushReplacementNamed(
                    '/reservation_screen',
                    arguments: arguments);
              },
              label: const Text('Nueva'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
