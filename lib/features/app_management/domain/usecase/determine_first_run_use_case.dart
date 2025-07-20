import 'package:initial_project/core/base/base_use_case.dart';
import 'package:initial_project/features/app_management/domain/repositories/app_management_repository.dart';

class DetermineFirstRunUseCase extends BaseUseCase<bool> {
  DetermineFirstRunUseCase(
    this._appManagementRepository,
    super.errorMessageHandler,
  );

  final AppManagementRepository _appManagementRepository;

  Future<bool> execute() async {
    return getRight(() async => _appManagementRepository.determineFirstRun());
  }
}
