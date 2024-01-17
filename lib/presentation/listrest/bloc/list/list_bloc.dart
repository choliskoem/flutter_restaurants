import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant/data/models/response/list_restaurant_response_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_dicoding_restaurant/data/datasources/restaurant_remote_datasource.dart';

part 'list_bloc.freezed.dart';
part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final RestaurantRemoteDatasource _restaurantRemoteDatasource;
  List<Restaurants> products = [];
  ListBloc(
    this._restaurantRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      // try {
      emit(const ListState.loading());
      final response = await _restaurantRemoteDatasource.getList();
      response.fold(
        (l) => emit(
          ListState.error(l),
        ),
        (r) {
          products = r.restaurants;

          emit(ListState.success(r.restaurants));
        },
      );
      // } catch (e) {

      //   emit(const ListState.connection());
      // }
    });

    on<_Search>((event, emit) async {
      try {
        emit(const ListState.loading());
        final newProducts = products
            .where((element) =>
                element.name.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        if (newProducts.isNotEmpty) {
          emit(ListState.success(newProducts));
        } else {
          emit(const ListState.error('Product not found'));
        }
      } catch (e) {
        emit(const ListState.connection());
      }
    });
    on<_FetchAll>((event, emit) async {
      try {
        emit(const ListState.loading());

        emit(ListState.success(products));
      } catch (e) {
        emit(const ListState.connection());
      }
    });
  }
}
