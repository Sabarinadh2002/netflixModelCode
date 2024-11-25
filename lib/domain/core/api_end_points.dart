import 'package:netflix_2/core/string.dart';
import 'package:netflix_2/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = "$kBaseUrl/trending/all/day?api_key=$apiKey";
  static const search =
      "$kBaseUrl/search/movie?api_key=$apiKey&query=spiderman";

  static const hotandNewMOVIE = '$kBaseUrl/discover/movie?api_key=$apiKey';
  static const hotandNewTV = '$kBaseUrl/discover/tv?api_key=$apiKey';    
}
