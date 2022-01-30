class AuthUserRequestModel {
  String? email;
  String? password;
  String? fcmToken;
  String? uid;

  AuthUserRequestModel({
    this.email,
    this.password,
    this.fcmToken,
    this.uid,
  });

  /*Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "fcmToken": fcmToken,
      };*/

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "fcmToken": fcmToken,
      };
}