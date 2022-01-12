import 'package:firebase_auth/firebase_auth.dart';
import 'package:restser_client/login/widgets/user_secure_storage.dart';

import '/contact/models/contact_model.dart';
import '/user/bloc/user_bloc.dart';
import '/user/models/user_model.dart';
import '/contact/bloc/contact_bloc.dart';
import '/contact/widgets/contact_list.dart';
//import '/login/bloc/login_bloc.dart';
import '/resources/api_resources.dart';
import '/widgets/my_appbar.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactBloc? _contactBloc;
  UserBloc? _userBloc;
  GlobalKey<AutoCompleteTextFieldState<UserModel>> key = GlobalKey();
  AutoCompleteTextField? searchTextField;
  TextEditingController controller = TextEditingController();
  var uid;

  @override
  void initState() {
    _contactBloc = BlocProvider.of<ContactBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    init();
    super.initState();
  }

  Future init() async {
    uid = await await FirebaseAuth.instance.currentUser!.uid;//UserSecureStorage().getUid();
    _userBloc!.add(GetUserList(uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: SideMenuScreen(),
      appBar: MyAppBar(
        title: "Contactos",
        context: context,
        leading: true,
      ),
      body: _buildClientList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Guardar"),
        onPressed: () {
          print(_contactBloc!.addList.length);
          print(_contactBloc!.removeList.length);
          if (_contactBloc!.addList.isNotEmpty ||
              _contactBloc!.removeList.isNotEmpty) {
            _contactBloc!.add(SetContactList());
          }
        },
      ),
    );
  }

  Widget _buildClientList() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return _buildLoading();
        } else if (state is UserListLoaded) {
          if (_contactBloc!.state.contactList == null) {
            _contactBloc!.add(GetContactList(uid,false));
          }
          return _buildClientCard();
        } else if (state is UserError) {
          //print(state.message);
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildClientCard() {
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is ContactListLoaded) {
          setState(() {
            ContactList(_contactBloc!);
          });
        } else if (state.setContactListStatus == true) {
          _contactBloc!.add(ChangeStatusBool());

          _alert('Exito', 'Cambios ingresados con exito', Colors.blue);
        } else if (state is ContactError) {
          _alert('Error', 'Error al ingresar los cambios', Colors.red);
        }
      },
      child: Center(
          child: Column(children: <Widget>[
        Column(
          children: <Widget>[
            searchTextField = AutoCompleteTextField<UserModel>(
              style: const TextStyle(color: Colors.black, fontSize: 16.0),
              decoration: InputDecoration(
                  suffixIcon: Container(
                    width: 85.0,
                    height: 60.0,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  filled: true,
                  hintText: 'Buscar Usuario',
                  hintStyle: const TextStyle(color: Colors.black)),
              itemSubmitted: (item) {
                setState(
                  () => {
                    searchTextField!.textField.controller!.text = item.email!,
                    _contactBloc!.add(AddContact(ContactModel(
                      email: item.email,
                      uid: uid,
                      idFriend: item.uid,
                      username: item.name,
                      date: APIResources.dateFormat.format(DateTime.now()),
                    )))
                  },
                );
              },
              clearOnSubmit: false,
              key: key,
              suggestions: _userBloc!.state.userList,
              itemBuilder: (context, item) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item.email!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                    ),
                    Text(
                      item.name!,
                    )
                  ],
                );
              },
              itemSorter: (a, b) {
                return a.email!.compareTo(b.email!);
              },
              itemFilter: (item, query) {
                return item.email!
                    .toLowerCase()
                    .startsWith(query.toLowerCase());
              },
            ),
          ],
        ),
        ContactList(_contactBloc!)
      ])),
    );
  }

  _alert(String title, String content, Color color) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: color,
          ),
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.pop(context, 'Ok')
              /*title.toLowerCase() == 'error'
                  ? Navigator.pop(context, 'Ok')
                  : Navigator.pop(context)*/
              //.pushReplacementNamed('/home', arguments: 3)
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
