import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:initial_project/core/di/service_locator.dart';
import 'package:initial_project/core/di/setup/setup_module.dart';
import 'package:initial_project/domain/usecases/get_device_info_usecase.dart';
import 'package:initial_project/domain/usecases/register_device_usecase.dart';

class UsecaseSetup implements SetupModule {
  final GetIt _serviceLocator;
  UsecaseSetup(this._serviceLocator);

  @override
  Future<void> setup() async {
    log('init usecase setup');
    _serviceLocator
      ..registerLazySingleton(() => GetDeviceInfoUsecase(locate(), locate()))
      ..registerLazySingleton(() => RegisterDeviceUsecase(locate(), locate()));
  }
}
