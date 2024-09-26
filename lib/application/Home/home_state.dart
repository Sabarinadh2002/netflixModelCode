part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
   required String stateId, 
   required List<hotAndNewData> pastyearMovieList,
   required List<hotAndNewData> trendingMovieList,
   required List<hotAndNewData> tenseDramasMovieList,
   required List<hotAndNewData> southIndianMovieList,
   required List<hotAndNewData> trendingTVList,
   required bool isloading,
   required bool hasError,
  }) = _Initial;

  factory HomeState.initial() => const HomeState(
  stateId: '0',  
  pastyearMovieList: [],
   trendingMovieList: [],
    tenseDramasMovieList: [],
     southIndianMovieList: [],
      trendingTVList: [], 
      isloading: false,
       hasError: false);


}
