part of 'fast_laugh_bloc.dart';

@freezed
class FastLaughEvent with _$FastLaughEvent {
  const factory FastLaughEvent.initialize() = Initialize;

  const factory FastLaughEvent.favoriteVideo({
    required int id
  }) = FavoriteVideo;
  const factory FastLaughEvent.unlikedVideo({
    required int id
  }) = UnlikedVideo;

}