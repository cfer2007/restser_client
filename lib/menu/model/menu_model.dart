import 'package:flutter/material.dart';

class MenuModel {
  int? idMenu;
  String? category;
  String? description;
  String? photo;

  MenuModel({
    @required this.idMenu,
    @required this.category,
    this.description,
    this.photo,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      idMenu: json['idMenu'],
      category: json['category'],
      description: json['description'],
      photo: json['photo'],
    );
  }
}
