import 'package:dartz/dartz.dart';
import 'package:netflix_2/domain/core/failure/main_failure.dart';
import 'package:netflix_2/domain/hotAndNew/model/hot_and_new_respo/hot_and_new_respo.dart';

abstract class HotAndNewService{
  Future<Either<MainFailure,HotAndNewRespo>> getHotAndNewMovieData();
  Future<Either<MainFailure,HotAndNewRespo>> getHotAndNewTVData();

}