import 'dart:async';
import '/resources/api_repository.dart';
import '/table/model/table_model.dart';
import 'package:bloc/bloc.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final ApiRepository _apiRepository = ApiRepository();
  TableBloc() : super(const TableInitial());

  @override
  Stream<TableState> mapEventToState(
    TableEvent event,
  ) async* {
    if (event is GetTable) {
      try {
        yield const TableLoading();
        print(event.idTable);
        final table = await _apiRepository.getTable(event.idTable);
        if (table.error) {
          yield TableError(table.errorMessage as String);
        } else {
          yield TableLoaded(table.data as TableModel);
        }
      } on NetworkError {
        yield const TableError("Failed to fetch data. is your device online?");
      }
    }
  }
}
