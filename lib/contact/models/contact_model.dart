import '/resources/api_resources.dart';

class ContactModel {
  int? idContact;
  String? idUser;
  String? idFriend;
  String? email;
  String? username;
  String? date;

  ContactModel(
      {this.idContact,
      this.idUser,
      this.idFriend,
      this.email,
      this.username,
      this.date});

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        idContact: json['idContact'],
        idUser: json['idUser'],
        idFriend: json['idFriend'],
        email: json['email'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        "user": {"idUser": idUser},
        "friend": {"idUser": idFriend},
        "date": APIResources.dateFormat.format(DateTime.now()),
      };
}
