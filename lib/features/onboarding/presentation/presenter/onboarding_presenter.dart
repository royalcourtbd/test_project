import 'dart:async';
import 'package:initial_project/core/base/base_presenter.dart';
import 'package:initial_project/core/utility/navigation_helpers.dart';
import 'package:initial_project/features/onboarding/presentation/presenter/onboarding_ui_state.dart';

class OnboardingPresenter extends BasePresenter<OnboardingUiState> {
  final Obs<OnboardingUiState> uiState = Obs<OnboardingUiState>(
    OnboardingUiState.empty(),
  );
  OnboardingUiState get currentUiState => uiState.value;

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: currentUiState.userMessage);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
