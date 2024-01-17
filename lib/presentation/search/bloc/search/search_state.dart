part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.success(List<SearchRestaurant> restaurants) = _Success;
  const factory SearchState.error(String message) = _Error;
  const factory SearchState.connection() = _Connection;
}
