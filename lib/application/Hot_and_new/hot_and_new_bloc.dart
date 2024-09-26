import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_2/domain/core/failure/main_failure.dart';
import 'package:netflix_2/domain/hotAndNew/model/hot_and_new_respo/hot_and_new_respo.dart';
import 'package:netflix_2/domain/hotAndNew/model/hot_and_new_respo/hot_and_new_service.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';


@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;

  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    // get hot and new movie data
    on<LoadDataComingSoon>((event, emit) async {
      //send loading to ui
      emit(
        const HotAndNewState(
          isloading: true,
          hasError: false,
          comingSoonList: [],
          everyOneWatchingList: [],
        ),
      );
      //get data from remote

      final _result = await _hotAndNewService.getHotAndNewMovieData();
      //data to state
      final newState = _result.fold((MainFailure failure) {
        return const HotAndNewState(
          isloading: false,
          hasError: true,
          comingSoonList: [],
          everyOneWatchingList: [],
        );
      }, (HotAndNewRespo resp) {
        return  HotAndNewState(
          isloading: false,
          hasError: false,
          comingSoonList: resp.results!,
          everyOneWatchingList: state.everyOneWatchingList,
        );
      });
      emit(newState);

    });

    //get hot and new tv data
    on<LoadDataEveryoneIsWatching>((event, emit) async {
       
      //send loading to ui
      emit(
        const HotAndNewState(
          isloading: true,
          hasError: false,
          comingSoonList: [],
          everyOneWatchingList: [],
        ),
      );
      //get data from remote

      final _result = await _hotAndNewService.getHotAndNewTVData();
      //data to state
      final newState = _result.fold((MainFailure failure) {
        return const HotAndNewState(
          isloading: false,
          hasError: true,
          comingSoonList: [],
          everyOneWatchingList: [],
        );
      }, (HotAndNewRespo resp) {
        return  HotAndNewState(
          isloading: false,
          hasError: false,
          comingSoonList: state.comingSoonList,
          everyOneWatchingList: resp.results!,
        );
      });
      emit(newState);
    });
  }
}
