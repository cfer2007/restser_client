import 'package:restser_client/order_reservation/bloc/order_reservation_bloc.dart';
import 'package:restser_client/reservation/screens/confirm_reservation_screen.dart';
import 'package:restser_client/reservation/screens/tracking_reservation_screen.dart';
import '/account/bloc/account_bloc.dart';
import '/account/screens/account_screen.dart';
import '/account/screens/choose_type_account_screen.dart';
import '/account/screens/multi_account_screen.dart';
import '/account/screens/select_account_screen.dart';
import '/user/bloc/user_bloc.dart';
import '/contact/bloc/contact_bloc.dart';
import '/contact/screen/contact_screen.dart';
import '/home/screens/home.dart';
import '/dish/bloc/dish_bloc.dart';
import '/dish/screens/dish_list_screen.dart';
import '/login/screen/login_screen.dart';
import '/menu/bloc/menu_bloc.dart';
import '/menu/screen/menu_screen.dart';
import '/order/bloc/order_bloc.dart';
import '/order/screens/order_screen.dart';
import '/order/screens/order_success.dart';
import '/reservation/bloc/reservation_bloc.dart';
import '/reservation/screens/reservation_screen.dart';
import '../reservation/widgets/reservation_arguments.dart';
import '/table/bloc/table_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final TableBloc _tableBloc = TableBloc();
  final ReservationBloc _reservationBloc = ReservationBloc();
  final OrderReservationBloc _orderReservationBloc = OrderReservationBloc();
  final AccountBloc _accountBloc = AccountBloc();
  final MenuBloc _menuBloc = MenuBloc();
  final DishBloc _dishBloc = DishBloc();
  final OrderBloc _orderBloc = OrderBloc();
  final ContactBloc _contactBloc = ContactBloc();
  final UserBloc _userBloc = UserBloc();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
              BlocProvider<OrderBloc>.value(
                value: _orderBloc,
              ),
              BlocProvider<ContactBloc>.value(
                value: _contactBloc,
              ),
              BlocProvider<UserBloc>.value(
                value: _userBloc,
              ),
              BlocProvider<OrderReservationBloc>.value(
                value: _orderReservationBloc,
              ),
            ],
            child: Home(index: settings.arguments as int),
          ),
        );

      case '/contact_screen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ContactBloc>.value(
                value: _contactBloc,
              ),
              BlocProvider<UserBloc>.value(
                value: _userBloc,
              ),
            ],
            child: const ContactScreen(),
          ),
        );

      case '/type_account':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountBloc>.value(
                value: _accountBloc,
              ),
              BlocProvider<ContactBloc>.value(
                value: _contactBloc,
              ),
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
            ],
            child: const ChooseTypeAccountScreen(),
          ),
        );

      case '/multi_account':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountBloc>.value(
                value: _accountBloc,
              ),
              BlocProvider<ContactBloc>.value(
                value: _contactBloc,
              ),
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
            ],
            child: const MultiAccountScreen(),
          ),
        );

      case '/select_account':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountBloc>.value(
                value: _accountBloc,
              ),
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
            ],
            child: const SelectAccountScreen(),
          ),
        );

      case '/account_screen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountBloc>.value(
                value: _accountBloc,
              ),
            ],
            child: const AccountScreen(),
          ),
        );

      case '/menu':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<MenuBloc>.value(
                value: _menuBloc,
              ),
            ],
            child: MenuScreen(idRestaurant: settings.arguments as String),
          ),
        );

      case '/dish_list':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
              BlocProvider<MenuBloc>.value(
                value: _menuBloc,
              ),
              BlocProvider<DishBloc>.value(
                value: _dishBloc,
              ),
              BlocProvider<OrderBloc>.value(
                value: _orderBloc,
              ),
            ],
            child: DishListScreen(index: settings.arguments as int),
          ),
        );

      case '/order':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountBloc>.value(
                value: _accountBloc,
              ),
              BlocProvider<OrderBloc>.value(
                value: _orderBloc,
              ),
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
            ],
            child: const OrderScreen(),
          ),
        );

      case '/order_success':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountBloc>.value(
                value: _accountBloc,
              ),
              BlocProvider<OrderBloc>.value(
                value: _orderBloc,
              ),
              BlocProvider<ContactBloc>.value(
                value: _contactBloc,
              ),
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
            ],
            child: const OrderSuccess(),
          ),
        );

      case '/reservation_screen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<AccountBloc>.value(
                value: _accountBloc,
              ),
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
              BlocProvider<TableBloc>.value(
                value: _tableBloc,
              ),
            ],
            child: ReservationScreen(
                arguments: settings.arguments as ReservationArguments),
          ),
        );
      case '/confirm_reservation_screen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
            ],
            child: const ConfirmReservationScreen(),
          ),
        );
      case '/reservation_tracking_screen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<OrderReservationBloc>.value(
                value: _orderReservationBloc,
              ),
              BlocProvider<ReservationBloc>.value(
                value: _reservationBloc,
              ),
            ],
            child: const ReservationTrackingScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }

  void dispose() {
    _tableBloc.close();
    _accountBloc.close();
    _dishBloc.close();
    _menuBloc.close();
    _reservationBloc.close();
    _orderBloc.close();
    _contactBloc.close();
    _userBloc.close();
    _orderReservationBloc.close();
  }
}
