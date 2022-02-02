// ignore_for_file: unnecessary_this

import 'dart:async';
import '/order/models/order_model.dart';
import '../models/order_dish_model.dart';
import '/resources/api_repository.dart';
import 'package:bloc/bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final ApiRepository _apiRepository = ApiRepository();
  OrderBloc() : super(OrderInitial());

  List<OrderDishModel> dishes = [];
  int? count = 0;
  double? total = 0;
  int? idOrder = 0;

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    try {
      if (event is ClearOrderBloc) {
        this.dishes = [];
        count = 0;
        total = 0;
        idOrder = 0;
        yield OrderInitial();
      }
      if (event is SetOrderError) {
        yield OrderError(event.message);
      }

      /*if (event is GetOrderListByClient) {
        final listOrder =
            await _apiRepository.getOrderListByClient(event.uid!);
        if (listOrder.error) {
          yield OrderError(listOrder.errorMessage as String);
        } else {
          yield OrderListByClientLoaded(listOrder.data as List<OrderModel>);
        }
      }*/
      if (event is AddToOrder) {
        if (dishes.isEmpty) {
          yield* _addElement(event.dish!);
        } else {
          bool exist = false;

          for (int i = 0; i < dishes.length; i++) {
            if (dishes[i].idDish == event.dish!.idDish) {
              exist = true;
              yield* _addUnity(event.dish!, i);
              return;
            }
          }
          if (!exist) {
            yield* _addElement(event.dish!);
          }
        }
      }

      if (event is DelFromOrder) {
        yield* _removeElement(event.index!);
      }

      if (event is Increment) {
        yield* _addUnity(dishes[event.index!], event.index!);
      }

      if (event is Decrement) {
        yield* _delUnity(dishes[event.index!], event.index!);
      }

      if (event is SetOrder) {
        final resOrder = await _apiRepository.setOrder(event.order!);
        if (resOrder.error) {
          yield OrderError(resOrder.errorMessage as String);
        } else {
          idOrder = int.parse(resOrder.data as String);
          for (var element in dishes) {
            element.idOrder = idOrder; //int.parse(resOrder.data),
          }
          final resDetailOrder = await _apiRepository.setDishesOrder(dishes);
          if (resDetailOrder.error) {
            yield OrderDetailError(resDetailOrder.errorMessage as String);
          } else {
            yield this.state.copyWith(
                dishes: dishes, setDishesStatus: true, idOrder: this.idOrder);
          }
        }
      }

      if (event is ClearOrderBloc) dishes = [];
    } catch (e) {
      print('error: ');
    }
  }

  Stream<OrderState> _addElement(OrderDishModel dish) async* {
    dishes.add(dish);
    this.count = this.count! + 1;
    this.total = this.total! + dish.price!;
    yield this.state.copyWith(
          dishes: this.dishes,
          count: this.count,
          total: this.total,
        );
  }

  Stream<OrderState> _removeElement(int index) async* {
    count = count! - dishes[index].units!;
    total = total! - (dishes[index].price! * dishes[index].units!);
    dishes.removeAt(index);
    yield this.state.copyWith(
          dishes: this.dishes,
          count: this.count,
          total: this.total,
        );
  }

  Stream<OrderState> _addUnity(OrderDishModel dish, int index) async* {
    dishes[index].units = dishes[index].units! + 1;
    this.count = this.count! + 1;
    this.total = this.total! + dish.price!;
    yield this.state.copyWith(
          dishes: this.dishes,
          count: this.count,
          total: this.total,
        );
  }

  Stream<OrderState> _delUnity(OrderDishModel dish, int index) async* {
    if (dishes[index].units == 1) {
      this.count = this.count! - 1;
      this.total = this.total! - dish.price!;
      dishes.removeAt(index);
    } else {
      dishes[index].units = dishes[index].units! - 1;
      this.count = this.count! - 1;
      this.total = this.total! - dish.price!;
    }

    yield this.state.copyWith(
          dishes: this.dishes,
          count: this.count,
          total: this.total,
        );
  }
}
