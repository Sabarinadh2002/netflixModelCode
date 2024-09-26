import 'package:dartz/dartz.dart';
import 'package:netflix_2/domain/core/failure/main_failure.dart';

import 'package:netflix_2/domain/search/model/search_respo/search_respo.dart';

abstract class SearchService {
  Future<Either<MainFailure, SearchResponse>> searchMoview({
    required String movieQuery,
  });
}
