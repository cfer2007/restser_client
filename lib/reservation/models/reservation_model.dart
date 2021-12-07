import '/user/models/user_model.dart';
import '/table/model/table_model.dart';

class ReservationModel {
  int? idReservation;
  String? status;
  String? start;
  String? finish;
  UserModel? user;
  TableModel? table;

  ReservationModel({
    this.idReservation,
    this.status,
    this.start,
    this.finish,
    this.user,
    this.table,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      ReservationModel(
        idReservation: json['idReservation'],
        status: json['status'],
        start: json['start'],
        finish: json['finish'],
        user: UserModel.fromJson(json['user']),
        table: TableModel.fromJson(json['table']),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "start": start,
        "user": {"idUser": user!.idUser},
        "table": {"idTable": table!.idTable},
      };
}
