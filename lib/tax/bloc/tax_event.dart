part of 'tax_bloc.dart';

abstract class TaxEvent {}

class GetTax extends TaxEvent {
  int idreservation;
  GetTax(this.idreservation);
}