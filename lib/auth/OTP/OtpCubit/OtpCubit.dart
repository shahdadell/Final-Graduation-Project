import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';

import 'OtpState.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepositoryContract authRepositoryContract;

  Timer? _timer;
  int _resendCountdown = 30;
  bool _canResend = false;

  OtpCubit({required this.authRepositoryContract}) : super(OtpInitialState()) {
    _startResendTimer();
  }

  int get resendCountdown => _resendCountdown;
  bool get canResend => _canResend;

  void _startResendTimer() {
    _canResend = false;
    _resendCountdown = 30;
    emit(OtpResendTimerState(_resendCountdown));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        _resendCountdown--;
        emit(OtpResendTimerState(_resendCountdown));
      } else {
        _canResend = true;
        timer.cancel();
        emit(OtpResendTimerState(0));
      }
    });
  }

  Future<void> verifyCode(
      BuildContext context, String email, String verifyCode) async {
    if (verifyCode.length != 5) {
      // عدلنا من 6 لـ 5
      emit(OtpErrorState(
          errorMessage: "Please enter a 5-digit code")); // عدلنا الرسالة
      return;
    }

    emit(OtpLoadingState());
    try {
      var response = await authRepositoryContract.verifyCode(email, verifyCode);
      if (response.status == "success") {
        emit(OtpSuccessState(response: response));
      } else {
        emit(OtpErrorState(
            errorMessage: response.message ?? "Verification failed"));
      }
    } catch (e) {
      emit(OtpErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> resendCode(String email) async {
    if (!_canResend) {
      emit(OtpErrorState(errorMessage: "Please wait to resend the code"));
      return;
    }

    emit(OtpLoadingState());
    try {
      var response = await authRepositoryContract.resendCode(email);
      if (response.status == "success") {
        emit(OtpResendSuccessState());
        _startResendTimer();
      } else {
        emit(OtpErrorState(errorMessage: "Failed to resend code"));
      }
    } catch (e) {
      emit(OtpErrorState(errorMessage: e.toString()));
    }
  }
}
