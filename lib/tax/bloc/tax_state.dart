part of 'tax_bloc.dart';

class TaxState {
  TaxModel? tax;

  TaxState({
    this.tax,
  });

  TaxState copyWith({
    TaxModel? tax,
  }) {
    return TaxState(
      tax: tax ?? this.tax,
    );
  }
}

class TaxInitial extends TaxState {}

class TaxLoading extends TaxState {
  TaxLoading();
}

class TaxLoaded extends TaxState {
  TaxModel? tax;
  TaxLoaded(this.tax);
}

class TaxError extends TaxState{
  final String message;
  TaxError(this.message);
}