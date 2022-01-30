import 'package:intl/intl.dart';

class APIResources {
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  static const _api = 'http://10.0.2.2:8080';
  static const header = {'Content-Type': 'application/json'};

  //static const signInEmail = _api + '/auth/signInWithEmailAndPassword';
  //static const signUpEmail = _api + '/auth/signUpWithEmailAndPassword';
  static const authUser = _api + '/auth/signUpUser';
  static const user = _api + '/user';
  static const table = _api + '/table';
  static const reservation = _api + '/reservation';
  static const account = _api + '/account';
  static const menu = _api + '/menu';
  static const order = _api + '/order';
  static const orderDetail = _api + '/order_detail';
  static const branchDish = _api + '/branch_dish';
  static const contact = _api + '/contact';
}

enum ReservationStatus {started, confirmed, finished }
enum OrderStatus {started, confirmed, processing, ready, delivered, paid }
enum tableStatus {available, busy}
