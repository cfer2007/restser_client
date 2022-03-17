part of 'tip_bloc.dart';

abstract class TipEvent {}

class GetTipList extends TipEvent {
  int idreservation;
  GetTipList(this.idreservation);
}