part of 'list_bloc.dart';

@freezed
class ListState with _$ListState {
  const factory ListState.initial() = _Initial;

  const factory ListState.loading() = _Loading;

  const factory ListState.success(List<Restaurants> restaurants) = _Success;

  const factory ListState.error(String message) = _Error;
  const factory ListState.noData(String data) = _NoData;

  const factory ListState.connection() = _Connection;
}
