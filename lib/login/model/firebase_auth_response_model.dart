class FirebaseResponseModel {
  String? uid;
  String? email;
  String? idToken;
  String? displayName;

  FirebaseResponseModel({
    this.uid,
    this.email,
    this.idToken,
    this.displayName,
  });

  factory FirebaseResponseModel.fromJson(Map<String, dynamic> json) => FirebaseResponseModel(
        uid: json['localId'],
        email: json['email'],
        idToken: json['idToken'],
        displayName: json['displayName'],
      );
}