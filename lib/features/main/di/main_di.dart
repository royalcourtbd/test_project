import 'package:initial_project/core/base/base_presenter.dart';
import 'package:initial_project/core/di/service_locator.dart';
import 'package:initial_project/features/main/data/repositories/main_repository_impl.dart';
import 'package:initial_project/features/main/domain/repositories/main_repository.dart';
import 'package:initial_project/features/main/presentation/presenter/main_presenter.dart';

import 'package:get_it/get_it.dart';

class MainDi {
  static Future<void> setup(GetIt serviceLocator) async {
    //  Data Source

    //  Repository
    serviceLocator.registerLazySingleton<MainRepository>(
      () => MainRepositoryImpl(),
    );

    // Use Cases

    // Presenters
    serviceLocator.registerFactory(
      () => loadPresenter(MainPresenter(locate())),
    );
  }
}
