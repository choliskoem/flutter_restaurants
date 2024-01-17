// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_restaurant/data/models/response/search_restaurant_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_dicoding_restaurant/data/datasources/restaurant_remote_datasource.dart';


part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RestaurantRemoteDatasource restaurantRemoteDatasource;

  SearchBloc(
    this.restaurantRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Search>((event, emit) async {
      try {
        emit(const _Loading());
        final response = await restaurantRemoteDatasource.search(event.query);

        response.fold(
          (l) => emit(SearchState.error(l)),
          (r) {
            emit(SearchState.success(r.restaurants));
          },
        );
      } catch (e) {
        emit(const SearchState.connection());
      }
    });
  }
}
