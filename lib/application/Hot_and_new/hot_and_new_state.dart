part of 'hot_and_new_bloc.dart';

@freezed
class HotAndNewState with _$HotAndNewState {
  const factory HotAndNewState({
    required bool isloading,
    required bool hasError,
    required List<hotAndNewData> comingSoonList,
    required List<hotAndNewData> everyOneWatchingList,
  }) = _Initial;

  factory HotAndNewState.initial() => const HotAndNewState(
        comingSoonList: [],
        everyOneWatchingList: [],
        isloading: false,
        hasError: false,
      );
}
