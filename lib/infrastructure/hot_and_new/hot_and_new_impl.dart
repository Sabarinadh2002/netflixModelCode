import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_2/domain/core/api_end_points.dart';
import 'package:netflix_2/domain/core/failure/main_failure.dart';
import 'package:netflix_2/domain/hotAndNew/model/hot_and_new_respo/hot_and_new_respo.dart';
import 'package:netflix_2/domain/hotAndNew/model/hot_and_new_respo/hot_and_new_service.dart';

@LazySingleton(as: HotAndNewService)
class HotAndNewImpl implements HotAndNewService{
  @override
  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewMovieData()async {
    try {
      final Response response = await Dio(BaseOptions())
          .get(ApiEndPoints.hotandNewMOVIE);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewRespo.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
  
  

  @override
  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewTVData() async {
    try {
      final Response response = await Dio(BaseOptions())
          .get(ApiEndPoints.hotandNewTV);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewRespo.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
  
}