import '/table/model/restaurant_model.dart';

class BranchModel {
  int? idBranch;
  String? name;
  String? address;
  String? phone;
  RestaurantModel? restaurant;

  BranchModel({
    this.idBranch,
    this.name,
    this.address,
    this.phone,
    this.restaurant,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      idBranch: json['idBranch'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      restaurant: RestaurantModel.fromJson(json['restaurant']),
    );
  }
}
