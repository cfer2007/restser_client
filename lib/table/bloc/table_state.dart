part of 'table_bloc.dart';

abstract class TableState {
  const TableState();
}

class TableInitial extends TableState {
  const TableInitial();
}

class TableLoading extends TableState {
  const TableLoading();
}

class TableLoaded extends TableState {
  final TableModel tableModel;
  const TableLoaded(this.tableModel);
}

class TableError extends TableState {
  final String message;
  const TableError(this.message);
}
