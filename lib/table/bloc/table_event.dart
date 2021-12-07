part of 'table_bloc.dart';

abstract class TableEvent {
  const TableEvent();
}

class GetTable extends TableEvent {
  final String idTable;
  GetTable(this.idTable);
}
