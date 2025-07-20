import 'package:fpdart/fpdart.dart';
import 'package:initial_project/domain/entities/app_update_entity.dart';

abstract class AppManagementRepository {
  /// Mark the app as done for the first time
  Future<void> doneFirstTime();

  /// Determine if the app is running for the first time
  Future<bool> determineFirstRun();

  /// Get the app update info
  Future<Either<String, AppUpdateEntity>> getAppUpdateInfo();
}
