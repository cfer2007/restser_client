class FirebaseSignupRequestModel {
  String? email;
  String? password;
  String? fcmToken;

  FirebaseSignupRequestModel({
    this.email,
    this.password,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "fcmToken": fcmToken,
      };
}