import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_2/domain/Downloads/i_downloads_repo.dart';
import 'package:netflix_2/domain/Downloads/models/downloads.dart';
import 'package:netflix_2/domain/core/failure/main_failure.dart';
import 'package:netflix_2/domain/search/model/search_respo/search_respo.dart';
import 'package:netflix_2/domain/search/search_service.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadService;
  final SearchService _searchService;

  SearchBloc(this._downloadService, this._searchService)
      : super(SearchState.initial()) {
    // idle state
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
          searchResultList: [],
          idleList: state.idleList,
          isloading: false,
          isError: false,
        ));
      } else {
        emit(const SearchState(
          searchResultList: [],
          idleList: [],
          isloading: true,
          isError: false,
        ));
        // get trending
        final _result = await _downloadService.getDownloadsImage();
        final _state = _result.fold((MainFailure f) {
          return const SearchState(
            searchResultList: [],
            idleList: [],
            isloading: false,
            isError: true,
          );
        }, (List<Downloads> list) {
          return SearchState(
            searchResultList: [],
            idleList: list,
            isloading: false,
            isError: false,
          );
        });
        // show to UI
        emit(_state);
      }
    });

    // search state
    on<SearchMovie>((event, emit) async {
      log('Searching for ${event.movieQuery}');
      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isloading: true,
        isError: false,
      ));
      // call search movie API
      final _result =
          await _searchService.searchMoview(movieQuery: event.movieQuery);
      final _state = _result.fold((MainFailure f) {
        log('Search Failed: ${f.toString()}');
        return const SearchState(
          searchResultList: [],
          idleList: [],
          isloading: false,
          isError: true,
        );
      }, (SearchResponse r) {
        log('Search succeeded: Found ${r.results.length} results');
        return SearchState(
          searchResultList: r.results,
          idleList: [],
          isloading: false,
          isError: false,
        );
      });
      // show to UI
      emit(_state);
    });

    
  }
}
