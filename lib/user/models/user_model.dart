class UserModel {
  String? idUser;
  String? name;
  String? email;
  String? password;
  String? accessToken;
  //String? tokenType;
  String? fcmToken;
  List? role;

  UserModel({
    this.idUser,
    this.name,
    this.email,
    this.password,
    this.accessToken,
    //this.tokenType,
    this.fcmToken,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json['idUser'],
        name: json['username'],
        email: json['email'],
        accessToken: json['accessToken'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "username": name,
        "role": role,
        "fcmToken": fcmToken,
      };
}
