class DishModel {
  int? idDish;
  int? idBranch;
  String? name;
  String? description;
  String? currency;
  double? price;
  String? photo;

  DishModel(
      {this.idDish,
      this.idBranch,
      this.name,
      this.description,
      this.currency,
      this.price,
      this.photo});

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      idDish: json['idDish'],
      idBranch: json['idBranch'],
      name: json['name'],
      description: json['description'],
      currency: json['currency'],
      price: json['price'],
      photo: json['photo'],
    );
  }
  Map<String, dynamic> toJson() => {
        "idDish": idDish,
        "idBranch": idBranch,
        "name": name,
        "description": description,
        "currency": currency,
        "price": price,
        "photo": photo,
      };
}
