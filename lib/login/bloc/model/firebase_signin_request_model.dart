class FirebaseSigninRequestModel {
  String? email;
  String? password;

  FirebaseSigninRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}