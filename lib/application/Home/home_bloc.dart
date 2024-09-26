import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_2/domain/core/failure/main_failure.dart';

import 'package:netflix_2/domain/hotAndNew/model/hot_and_new_respo/hot_and_new_respo.dart';
import 'package:netflix_2/domain/hotAndNew/model/hot_and_new_respo/hot_and_new_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  
   
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    //on event get homescreen data
    on<GetHomeScreenData>((event, emit) async {
      // send loading to ui
      emit(state.copyWith(isloading: true, hasError: false));

      // get data
      final _movieresult = await _homeService.getHotAndNewMovieData();
      final _tvresult = await _homeService.getHotAndNewTVData();
      // transform data
     final _state1 =   _movieresult.fold(
        (MainFailure failure) {
          return   HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastyearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTVList: [],
            isloading: false,
            hasError: true,
          );
        },
        (HotAndNewRespo resp) {
          final pastyear = resp.results;
          final trending = resp.results;
          final drams = resp.results;
          final southInadian = resp.results;
          pastyear!.shuffle();
          trending!.shuffle();
          drams!.shuffle();
          southInadian!.shuffle();

          return  HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastyearMovieList: pastyear,
            trendingMovieList: trending,
            tenseDramasMovieList: drams,
            southIndianMovieList: southInadian,
            trendingTVList: state.trendingTVList,
            isloading: false,
            hasError: false,
          );
        },
      );
      emit(_state1);

      final _state2 =  _tvresult.fold(
        (MainFailure failure) {
          return  HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastyearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTVList: [],
            isloading: false,
            hasError: true,
          );
        },
        (HotAndNewRespo resp){
          final to10List = resp.results;
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastyearMovieList: state.pastyearMovieList,
            trendingMovieList: to10List!,
            tenseDramasMovieList: state.tenseDramasMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTVList: to10List,
            isloading: false,
            hasError: false,
          );
        },
      );

      emit(_state2);

    });
  }
}
