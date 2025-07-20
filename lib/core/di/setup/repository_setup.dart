import 'package:get_it/get_it.dart';
import 'package:initial_project/core/di/service_locator.dart';
import 'package:initial_project/core/di/setup/setup_module.dart';
import 'package:initial_project/data/repositories/device_info_repository_impl.dart';
import 'package:initial_project/domain/repositories/device_info_repository.dart';

class RepositorySetup implements SetupModule {
  final GetIt _serviceLocator;
  RepositorySetup(this._serviceLocator);

  @override
  Future<void> setup() async {
    _serviceLocator.registerLazySingleton<DeviceInfoRepository>(
      () => DeviceInfoRepositoryImpl(locate(), locate(), locate()),
    );
  }
}
