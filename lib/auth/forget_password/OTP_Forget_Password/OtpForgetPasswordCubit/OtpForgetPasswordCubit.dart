import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'OtpForgetPasswordState.dart';

class OtpForgetPasswordCubit extends Cubit<OtpForgetPasswordState> {
  final AuthRepositoryContract authRepositoryContract;
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController()); // عدلنا من 6 لـ 5
  List<FocusNode> focusNodes =
      List.generate(5, (index) => FocusNode()); // عدلنا من 6 لـ 5
  Timer? _timer;
  int _resendCountdown = 30;
  bool _canResend = false;

  OtpForgetPasswordCubit({required this.authRepositoryContract})
      : super(OtpForgetPasswordInitialState()) {
    _startResendTimer();
  }

  int get resendCountdown => _resendCountdown;
  bool get canResend => _canResend;

  void _startResendTimer() {
    _canResend = false;
    _resendCountdown = 30;
    emit(OtpForgetPasswordResendTimerState(_resendCountdown));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        _resendCountdown--;
        emit(OtpForgetPasswordResendTimerState(_resendCountdown));
      } else {
        _canResend = true;
        timer.cancel();
        emit(OtpForgetPasswordResendTimerState(0));
      }
    });
  }

  Future<void> verifyCodeForgetPassword(
      BuildContext context, String email) async {
    String verifyCode = controllers.map((controller) => controller.text).join();
    if (verifyCode.length != 5) {
      // عدلنا من 6 لـ 5
      emit(OtpForgetPasswordErrorState(
          errorMessage: "Please enter a 5-digit code")); // عدلنا النص
      return;
    }

    emit(OtpForgetPasswordLoadingState());
    try {
      var response = await authRepositoryContract.verifyCodeForgetPassword(
          email, verifyCode);
      if (response.status == "success") {
        emit(OtpForgetPasswordSuccessState(response: response));
      } else {
        emit(OtpForgetPasswordErrorState(
            errorMessage: response.message ?? "Verification failed"));
      }
    } catch (e) {
      emit(OtpForgetPasswordErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> resendCode(String email) async {
    if (!_canResend) {
      emit(OtpForgetPasswordErrorState(
          errorMessage: "Please wait to resend the code"));
      return;
    }

    emit(OtpForgetPasswordLoadingState());
    try {
      var response = await authRepositoryContract.resendCode(email);
      if (response.status == "success") {
        emit(OtpForgetPasswordResendSuccessState());
        _startResendTimer();
      } else {
        emit(
            OtpForgetPasswordErrorState(errorMessage: "Failed to resend code"));
      }
    } catch (e) {
      emit(OtpForgetPasswordErrorState(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    return super.close();
  }
}
