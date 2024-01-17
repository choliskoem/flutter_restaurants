import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_dicoding_restaurant/data/datasources/restaurant_remote_datasource.dart';
import 'package:flutter_dicoding_restaurant/data/models/response/detail_restaurant_response_model.dart';



part 'detail_bloc.freezed.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final RestaurantRemoteDatasource _restaurantRemoteDatasource;

  DetailBloc(this._restaurantRemoteDatasource) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      try {
        emit(const DetailState.loading());
        final response = await _restaurantRemoteDatasource.getDetail(event.id);
        response.fold(
          (l) => emit(DetailState.error(l)),
          (r) {
            emit(DetailState.success(r.restaurant));
          },
        );
      } catch (e) {
        emit(const DetailState.connection());
      }
    });
  }
}
