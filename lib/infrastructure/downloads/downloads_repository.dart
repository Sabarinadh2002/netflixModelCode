import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_2/domain/Downloads/i_downloads_repo.dart';
import 'package:netflix_2/domain/Downloads/models/downloads.dart';
import 'package:netflix_2/domain/core/api_end_points.dart';
import 'package:netflix_2/domain/core/failure/main_failure.dart';

@LazySingleton(as: IDownloadsRepo)
class DownloadsRepository implements IDownloadsRepo {
  @override
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImage() async {
    try {
      // final url = ApiEndPoints.downloads;
      // log('Requesting URL: $url');
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.downloads);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //log('Responce data: ${response.data}');
        final List result = response.data['results'] ?? [];
        final downloadsList = result.map((e) {
          return Downloads.fromJson(e);
        }).toList();

        print(downloadsList);

        return Right(downloadsList);
      } else {
        //log('Server returned error with status code :${response.statusCode}');
        return const Left(MainFailure.serverFailure());
      }
    } on DioError catch (e) {
      log('Request failed with error: ${e.message}');
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
