import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_2/domain/core/di/inhectable.config.dart';


final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async {
  $initGetIt(getIt, environment: Environment.prod);
}
