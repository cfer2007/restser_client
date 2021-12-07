import '/widgets/my_appbar.dart';
import '/account/widgets/profile_menu.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: SideMenuScreen(),
      appBar: MyAppBar(
        title: "Perfil",
        context: context,
        leading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            profilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Mi Cuenta",
              icon: const Icon(Icons.person), //"assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Friends",
              icon: const Icon(Icons.group_add), //"assets/icons/User Icon.svg",
              press: () => {Navigator.of(context).pushNamed('/contact_screen')},
            ),
            ProfileMenu(
              text: "Metodos de Pago",
              icon: const Icon(Icons.payment), //"assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Configuración",
              icon: const Icon(Icons.settings),
              press: () {},
            ),
            ProfileMenu(
              text: "Cerrar Sesión",
              icon: const Icon(Icons.logout),
              press: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget profilePic() {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        clipBehavior: Clip.none, fit: StackFit.expand,
        children: [
          const CircleAvatar(
            child: Icon(Icons.person_outline),
            //backgroundImage: AssetImage("assets/images/Profile Image.png"),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            left: 60,
            top: 65,
            child: SizedBox(
              height: 20,
              width: 20,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                  side: const BorderSide(color: Colors.white),
                ),
                color: Colors.grey, //Color(0xFFF5F6F9),
                onPressed: () {},
                child: const Icon(
                  Icons.add_a_photo,
                  size: 18, //SvgPicture.asset("assets/icons/Camera Icon.svg"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
