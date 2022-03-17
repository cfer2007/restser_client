import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restser_client/account/bloc/account_bloc.dart';
import 'package:restser_client/account/models/account_model.dart';
import 'package:restser_client/tax/bloc/tax_bloc.dart';
import 'package:restser_client/tip/bloc/tip_bloc.dart';
import 'package:restser_client/widgets/my_appbar.dart';

class FinishReservationScreen extends StatefulWidget {
  final int idReservation;
  const FinishReservationScreen({required this.idReservation, Key? key}) : super(key: key);

  @override
  State<FinishReservationScreen> createState() => _FinishReservationScreenState();
}

class _FinishReservationScreenState extends State<FinishReservationScreen> {
  AccountBloc? _accountBloc;
  TipBloc? _tipBloc;
  TaxBloc? _taxBloc;
  String? tipSelectedItem;
  int tipPercent=0;

  @override
  void initState() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _tipBloc = BlocProvider.of<TipBloc>(context);
    _taxBloc = BlocProvider.of<TaxBloc>(context);
    
    _accountBloc!.add(GetAccountList(widget.idReservation.toString()));
    _tipBloc!.add(GetTipList(widget.idReservation));
    _taxBloc!.add(GetTax(widget.idReservation));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context,state){
        if(state is GetAccountReservationListLoaded){
          return _buildView(state.accountReservationList!);
        }
        else {
          return _buildLoading();
        }
      }
    );
  }

  Widget _buildView(List<AccountModel> list){
    return Scaffold(
      appBar: MyAppBar(title: '', context: context, leading: true),
      body: _buildAccountListView(list)
    );
  }

  Widget _buildTipMenu(){
    return BlocBuilder<TipBloc, TipState>(
      builder: (context, state){
        if(state is TipListLoaded){
          return DropdownButton<String>(
            items: _tipBloc!.state.tipList!.map((item) {
              return DropdownMenuItem<String>(
                child: Text('${item.percentage!.toString()}%'),
                value: item.percentage.toString()
              );
            }).toList(),
            onChanged: (newVal) {      
              setState(() {                
                tipSelectedItem = newVal;  
                tipPercent = int.parse(tipSelectedItem!);              
              });                      
            },
            value: tipSelectedItem,
          );
        }
        else{
          return const Text('0');
        }
      }, 
    );
  }  

  Widget _buildAccountListView(List<AccountModel> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index){
        return Card(
          child: Column(
            children: [
              ExpansionTile(
                title: Text(list[index].user!.email!),
                initiallyExpanded: true,
                children: [
                  ListTile(
                    title: const Text('subtotal'),
                    trailing: Text(list[index].subtotal.toString()),
                  ),
                  ListTile(
                    title: const Text('impuestos'),
                    trailing: Wrap(
                      spacing: 60,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(_taxBloc!.state.tax!.percentage.toString()),
                        Text((list[index].subtotal!*(_taxBloc!.state.tax!.percentage!/100)).toString()),
                        
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('propina'),
                    trailing: Wrap(
                      spacing: 60,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _buildTipMenu(),
                        Text((list[index].subtotal!*(tipPercent == null ? 0 : (tipPercent/100))).toString()),
                        
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('total'),
                    trailing: Text(list[index].subtotal.toString()),                    
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}

Widget _buildLoading() => const Center(child: CircularProgressIndicator());