import 'package:restser_client/account/models/account_model.dart';

import '/user/models/user_model.dart';
import '/table/model/table_model.dart';

class ReservationModel {
  int? idReservation;
  String? status;
  String? start;
  String? finish;
  UserModel? user;
  TableModel? table;
  List<AccountModel>? listAccount;

  ReservationModel({
    this.idReservation,
    this.status,
    this.start,
    this.finish,
    this.user,
    this.table,
    this.listAccount,
  });
  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    var list = json['listAccount'] as List;
    List<AccountModel> listA =
        list.map((i) => AccountModel.fromJson(i)).toList();

    return ReservationModel(
      idReservation: json['idReservation'],
        status: json['status'],
        start: json['start'],
        finish: json['finish'],
        user: UserModel.fromJson(json['user']),
        table: TableModel.fromJson(json['table']),
        listAccount: listA,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "start": start,
        "user": {"uid": user!.uid},
        "table": {"idTable": table!.idTable},
      };

  Map<String, dynamic> toJsonConfirm()  {
    List list = listAccount!.map((e) => e.toJsonConfirm()).toList();
    return {
        "idReservation": idReservation,
        "status": status,
        //"start": start,
        "listAccount": list,
      };    
  }
}
