part of 'list_bloc.dart';

@freezed
class ListEvent with _$ListEvent {
  const factory ListEvent.started() = _Started;
    const factory ListEvent.fetch() = _Fetch;
    const factory ListEvent.search(String query) = _Search;
    const factory ListEvent.fetchAll() = _FetchAll;
    
}