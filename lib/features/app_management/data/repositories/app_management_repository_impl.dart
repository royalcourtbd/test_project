import 'package:fpdart/fpdart.dart';
import 'package:initial_project/core/utility/trial_utility.dart';
import 'package:initial_project/data/models/app_update_model.dart';
import 'package:initial_project/data/services/backend_as_a_service.dart';
import 'package:initial_project/domain/entities/app_update_entity.dart';
import 'package:initial_project/features/app_management/data/datasource/app_management_local_data_source.dart';
import 'package:initial_project/features/app_management/domain/repositories/app_management_repository.dart';

class AppManagementRepositoryImpl implements AppManagementRepository {
  AppManagementRepositoryImpl(
    this._appManagementLocalDataSource,
    this._backendService,
  );

  final AppManagementLocalDataSource _appManagementLocalDataSource;
  final BackendAsAService _backendService;

  @override
  Future<void> doneFirstTime() => _appManagementLocalDataSource.doneFirstTime();

  @override
  Future<bool> determineFirstRun() async {
    final bool? shouldCountAsFirstTime = await catchAndReturnFuture(() async {
      final bool isFirstTime = await _appManagementLocalDataSource
          .determineFirstRun();
      if (isFirstTime) return true;
      return false;
    });

    return shouldCountAsFirstTime ?? true;
  }

  @override
  Future<Either<String, AppUpdateEntity>> getAppUpdateInfo() async {
    try {
      final Map<String, dynamic> result = await _backendService
          .getAppUpdateInfo();
      return right(AppUpdateModel.fromJson(result));
    } catch (e) {
      return left(e.toString());
    }
  }
}
