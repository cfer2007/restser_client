import 'package:restser_client/login/widgets/user_secure_storage.dart';

import '/login/bloc/login_bloc.dart';
import '/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{ 
    final userRepository = UserSecureStorage();
    runApp(BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(userRepository),
      child: MyApp(),
    ));}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
