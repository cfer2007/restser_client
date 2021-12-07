import '/account/bloc/account_bloc.dart';
import '/contact/bloc/contact_bloc.dart';
import '/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseTypeAccountScreen extends StatefulWidget {
  const ChooseTypeAccountScreen({Key? key}) : super(key: key);

  @override
  _ChooseTypeAccountScreenState createState() =>
      _ChooseTypeAccountScreenState();
}

class _ChooseTypeAccountScreenState extends State<ChooseTypeAccountScreen> {
  ContactBloc? _contactBloc;
  AccountBloc? _accountBloc;

  @override
  Widget build(BuildContext context) {
    _contactBloc = BlocProvider.of<ContactBloc>(context);
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    return BlocConsumer<ContactBloc, ContactState>(
      bloc: _contactBloc,
      listener: (context, state) {
        if (state is ContactListLoaded) {
          Navigator.of(context).pushNamed(
            '/multi_account',
          );
        }
        if (state is ContactError) print(state.message);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: MyAppBar(
            title: "Tipo de Cuenta",
            context: context,
            leading: true,
          ),
          body: Container(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('La reservación se ha creado exitosamente'),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: const Text('Compartir Reservación'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.group),
                  label: const Text('Dividir Cuenta'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(55, 10, 55, 10),
                    ),
                  ),
                  onPressed: () {
                    _contactBloc!.add(GetContactList(
                        _accountBloc!.state.account!.user!.idUser!, true));
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Una Cuenta'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(62, 10, 62, 10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/menu',
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
