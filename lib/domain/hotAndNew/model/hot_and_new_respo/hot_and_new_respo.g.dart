// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_and_new_respo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotAndNewRespo _$HotAndNewRespoFromJson(Map<String, dynamic> json) =>
    HotAndNewRespo(
      page: (json['page'] as num?)?.toInt(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => hotAndNewData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HotAndNewRespoToJson(HotAndNewRespo instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };

hotAndNewData _$hotAndNewDataFromJson(Map<String, dynamic> json) =>
    hotAndNewData(
      backdropPath: json['backdrop_path'] as String?,
      id: (json['id'] as num?)?.toInt(),
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String?,
    )..originalName = json['original_name'] as String?;

Map<String, dynamic> _$hotAndNewDataToJson(hotAndNewData instance) =>
    <String, dynamic>{
      'backdrop_path': instance.backdropPath,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
    };
