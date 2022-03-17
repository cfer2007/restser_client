part of 'tip_bloc.dart';

class TipState {
  List<TipModel>? tipList;

  TipState({
    this.tipList,
  });

  TipState copyWith({
    List<TipModel>? tipList,
  }) {
    return TipState(
      tipList: tipList ?? this.tipList,
    );
  }
}

class TipInitial extends TipState {}

class TipLoading extends TipState {
  TipLoading();
}

class TipListLoaded extends TipState {
  List<TipModel>? tipList;
  TipListLoaded(this.tipList);
}

class TipError extends TipState{
  final String message;
  TipError(this.message);
}