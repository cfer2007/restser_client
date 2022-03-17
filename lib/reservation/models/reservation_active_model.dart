import 'package:restser_client/account/models/account_model.dart';
import 'package:restser_client/reservation/models/reservation_model.dart';

class ReservationActiveModel{
  //int? idReservation;
  ReservationModel? reservation;
  List<AccountModel>? listAccount;

  ReservationActiveModel({
    //this.idReservation,
    this.reservation,
    this.listAccount,
  });

  factory ReservationActiveModel.fromJson(Map<String, dynamic> json){
     var list = json['accountList'] as List;
    List<AccountModel> listA =
        list.map((i) => AccountModel.fromJson(i)).toList();
        
    return ReservationActiveModel(
      //idReservation: json['idReservation'],
      reservation: ReservationModel.fromJson(json['reservation']),
      listAccount: listA,
    );
  }
  Map<String, dynamic> toJson()  {
    List list = listAccount!.map((e) => e.toJsonConfirm()).toList();
    return {
        //"idReservation": idReservation,
        
        "listAccount": list,
      };    
  }
}