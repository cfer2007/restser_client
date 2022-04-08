import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restser_client/account/bloc/account_bloc.dart';
import 'package:restser_client/resources/api_resources.dart';
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
  String? tipSelectedItem = '0';
  
  @override
  void initState() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _tipBloc = BlocProvider.of<TipBloc>(context);
    
    _tipBloc!.add(GetTipList(widget.idReservation));
    _accountBloc!.add(GetCollectAccountList(widget.idReservation));    

    super.initState();
  }

  Widget _buildTipBloc(int index){
    return BlocBuilder<TipBloc, TipState>(
      builder: (context,state){
        if(state is TipListLoaded){
          return _buildTipMenu(index);
        }
        else{
          return const Text('loading tip');
        }
      },
      
    );       
  }


  Widget _buildTipMenu(int index){
  
    tipSelectedItem= _accountBloc!.state.collectAccountList![index].tipPercentage.toString();
    return DropdownButton<String>(
      items: _tipBloc!.state.tipList!.map((item) {
        return DropdownMenuItem<String>(
          child: Text('${item.percentage!.toString()}%'),
          value: item.percentage.toString()
        );
      }).toList(),
      onChanged: (newVal) {
        setState(() {
          _accountBloc!.add(CalculateTip(int.parse(newVal!), index));           
        });
      },
      value: tipSelectedItem,
    );        
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context,state){
        if(state is CollectAccountListLoaded){
          return _buildView();
        }
        
        else {
          return _buildLoading();
        }
      }
    );
  }

  Widget _buildView(){
    return Scaffold(
      appBar: MyAppBar(title: '', context: context, leading: true),
      body: _buildAccountListView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:FloatingActionButton.extended(
        onPressed: (){
          _accountBloc!.add(StartCollectingAccounts(
            OrderReservationStatus.collecting.name,
            widget.idReservation
          ));
          Navigator.of(context).pop(true);
        },
        label: const Text('Confirmar'),
      ),
    );
  }

  Widget _buildAccountListView(){
    return ListView.builder(
      itemCount: _accountBloc!.state.collectAccountList!.length,
      itemBuilder: (context, index){
        return Card(
          child: Column(
            children: [
              ExpansionTile(
                title: Text(_accountBloc!.state.collectAccountList![index].user!.email!),
                initiallyExpanded: _accountBloc!.state.collectAccountList![index].subtotal == 0 ? false : true,
                children: [
                  ListTile(
                    title: const Text('subtotal'),
                    trailing: Text(_accountBloc!.state.collectAccountList![index].subtotal.toString()),
                  ),
                  ListTile(
                    title: const Text('impuestos'),
                    subtitle: Text('${_accountBloc!.state.collectAccountList![index].taxPercentage!.toString()}%'),
                    trailing: Text(_accountBloc!.state.collectAccountList![index].tax!.toString()),
                  ),
                  ListTile(
                    title: const Text('propina'),
                    subtitle: _buildTipBloc(index),
                    trailing: Text(_accountBloc!.state.collectAccountList![index].tip!.toString()),
                  ),
                  ListTile(
                    title: const Text('total'),
                    trailing: Text(_accountBloc!.state.collectAccountList![index].total!.toString()),
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