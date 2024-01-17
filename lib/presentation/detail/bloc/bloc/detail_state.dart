part of 'detail_bloc.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState.initial() = _Initial;
    const factory DetailState.loading() = _Loading;
    const factory DetailState.success(Restaurant restaurant) = _Success;
    const factory DetailState.error(String message) = _Error;
      const factory DetailState.connection() = _Connection;
}
