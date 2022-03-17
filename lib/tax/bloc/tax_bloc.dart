import 'package:bloc/bloc.dart';
import 'package:restser_client/resources/api_repository.dart';
import 'package:restser_client/tax/model/tax_model.dart';

part 'tax_event.dart';
part 'tax_state.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  final ApiRepository _apiRepository = ApiRepository();
  TaxBloc() : super(TaxInitial());

  @override
  Stream<TaxState> mapEventToState(TaxEvent event) async* {
    try{
      if(event is GetTax){
        yield TaxLoading();
        final result = await _apiRepository.getTax(event.idreservation);
        if(result.error){
          print(result.errorMessage);
          yield TaxError(result.errorMessage as String);
        }
        else {
          state.copyWith(tax: result.data as TaxModel);
          yield TaxLoaded(result.data as TaxModel);
        }
      }
    }
    catch(e){
      print(e);
    }
  }
}
