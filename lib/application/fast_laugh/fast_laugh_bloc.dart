

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_2/domain/Downloads/i_downloads_repo.dart';
import 'package:netflix_2/domain/Downloads/models/downloads.dart';

part 'fast_laugh_bloc.freezed.dart';
part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart'; 

final dummyvideoUrl = [
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
];

ValueNotifier<Set<int>> likedVideoNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadsRepo _downloadService,
  ) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      // sending loading to ui
      emit(const FastLaughState(
        videoList: [],
        isloading: true,
        isError: false,
      ));
      //get trending movies
      final _result = await _downloadService.getDownloadsImage();
      final _state = _result.fold(
        (l) {
          return  FastLaughState(
            videoList: [],
            isloading: false,
            isError: true,
          );
        },
        (resp) => FastLaughState(
          videoList: resp,
          isloading: false,
          isError: false,
        ),
      );
      //send to ui

      emit(_state);
    });

    on<FavoriteVideo>((event, emit) async {
      likedVideoNotifier.value.add(event.id);
      likedVideoNotifier.notifyListeners();
    });

    on<UnlikedVideo>((event, emit) async {
      likedVideoNotifier.value.remove(event.id);
      likedVideoNotifier.notifyListeners();
    });
  }
}
