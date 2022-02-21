import 'package:restser_client/account/models/account_model.dart';

class ReservationActiveModel{
  int? idReservation;
  List<AccountModel>? listAccount;

  ReservationActiveModel({
    this.idReservation,
    this.listAccount,
  });

  factory ReservationActiveModel.fromJson(Map<String, dynamic> json){
     var list = json['accountList'] as List;
    List<AccountModel> listA =
        list.map((i) => AccountModel.fromJson(i)).toList();
        
    return ReservationActiveModel(
      idReservation: json['idReservation'],
      listAccount: listA,
    );
  }
  Map<String, dynamic> toJson()  {
    List list = listAccount!.map((e) => e.toJsonConfirm()).toList();
    return {
        "idReservation": idReservation,
        "listAccount": list,
      };    
  }
}