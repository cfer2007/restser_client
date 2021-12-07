import 'package:flutter/material.dart';

class ReservationArguments {
  String title;
  String description;
  String txtFieldLabel;
  String txtCodeBtn;
  String txtQrBtn;
  Icon codeBtnIcon;
  Icon qrBtnIcon;
  bool isNewReservation;

  ReservationArguments({
    required this.title,
    required this.description,
    required this.txtFieldLabel,
    required this.txtCodeBtn,
    required this.txtQrBtn,
    required this.codeBtnIcon,
    required this.qrBtnIcon,
    required this.isNewReservation,
  });
}
