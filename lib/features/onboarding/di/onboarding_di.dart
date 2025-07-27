import 'package:initial_project/core/base/base_presenter.dart';
import 'package:initial_project/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:initial_project/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:initial_project/features/onboarding/presentation/presenter/onboarding_presenter.dart';

import 'package:get_it/get_it.dart';

class OnboardingDi {
  static Future<void> setup(GetIt serviceLocator) async {
    //  Data Source

    //  Repository
    serviceLocator.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(),
    );

    // Use Cases

    // Presenters
    serviceLocator.registerFactory(
      () => loadPresenter(OnboardingPresenter()),
    );
  }
}
