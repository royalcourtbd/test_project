import 'package:initial_project/core/base/base_use_case.dart';
import 'package:initial_project/features/app_management/domain/repositories/app_management_repository.dart';

class SaveFirstTimeUseCase extends BaseUseCase<void> {
  final AppManagementRepository appManagementRepository;

  SaveFirstTimeUseCase(super.errorMessageHandler, this.appManagementRepository);

  Future<void> execute() async {
    await doVoid(() => appManagementRepository.doneFirstTime());
  }
}
