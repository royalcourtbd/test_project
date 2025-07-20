import 'package:fpdart/fpdart.dart';
import 'package:initial_project/core/base/base_use_case.dart';
import 'package:initial_project/domain/repositories/device_info_repository.dart';
import 'package:initial_project/domain/service/error_message_handler.dart';

class RegisterDeviceUsecase extends BaseUseCase<void> {
  final DeviceInfoRepository _deviceInfoRepository;

  RegisterDeviceUsecase(
    this._deviceInfoRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, void>> execute() {
    return mapResultToEither(() async {
      await _deviceInfoRepository.registerDevice();
      return;
    });
  }
}
