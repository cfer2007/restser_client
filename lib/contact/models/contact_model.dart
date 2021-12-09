import '/resources/api_resources.dart';

class ContactModel {
  int? idContact;
  String? uid;
  String? idFriend;
  String? email;
  String? username;
  String? date;

  ContactModel(
      {this.idContact,
      this.uid,
      this.idFriend,
      this.email,
      this.username,
      this.date});

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        idContact: json['idContact'],
        uid: json['uid'],
        idFriend: json['idFriend'],
        email: json['email'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        "user": {"uid": uid},
        "friend": {"uid": idFriend},
        "date": APIResources.dateFormat.format(DateTime.now()),
      };
}
