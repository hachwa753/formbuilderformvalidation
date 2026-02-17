import 'package:flutter_api_fetch/core/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
//flutter pub run build_runner build --delete-conflicting-outputs

final getIt = GetIt.instance;

@InjectableInit()
void configureDependancy() {
  getIt.init();
}
