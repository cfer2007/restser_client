class RestaurantModel {
  int? idRestaurant;
  String? name;
  String? description;
  String? address;
  String? nit;
  String? error;
  String? logo;

  RestaurantModel({
    this.idRestaurant,
    this.name,
    this.description,
    this.address,
    this.nit,
    this.logo,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      idRestaurant: json['idRestaurant'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      nit: json['nit'],
      logo: json['logo'],
    );
  }
}
