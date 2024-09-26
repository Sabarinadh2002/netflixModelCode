import 'package:dartz/dartz.dart';
import 'package:netflix_2/domain/Downloads/models/downloads.dart';
import 'package:netflix_2/domain/core/failure/main_failure.dart';

abstract class IDownloadsRepo {
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImage();
}
