import 'package:bloc/bloc.dart';
import 'package:restser_client/resources/api_repository.dart';
import 'package:restser_client/tip/model/tip_model.dart';

part 'tip_event.dart';
part 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  final ApiRepository _apiRepository = ApiRepository();
  TipBloc() : super(TipInitial());

  @override
  Stream<TipState> mapEventToState(TipEvent event) async* {
    try{
      if(event is GetTipList){
        yield TipLoading();
        final result = await _apiRepository.getListTip(event.idreservation);
        if(result.error){
          print(result.errorMessage);
          yield TipError(result.errorMessage as String);
        }
        else {
          List<TipModel> list = result.data as List<TipModel>;
          print(list.length);
          state.copyWith(tipList: result.data as List<TipModel>);
          yield TipListLoaded(result.data as List<TipModel>);
        }
      }
    }
    catch(e){
      print(e);
    }
  }
}
