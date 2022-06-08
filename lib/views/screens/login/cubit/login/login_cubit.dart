import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  void emailChanged(String value) {
    // Here, copyWith is use to only affect new values of only necessary field
    // Each email modification -> field email get new value and status is initial
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    // Here, copyWith is use to only affect new values of only necessary field
    // Each password modification -> field password get new value and status is initial
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  Future<void> logInWithCredentials() async {
    // If the login is already launch, current changment is finally not triggered
    if (state.status == LoginStatus.submitting) return;
    // Else -> submitting status is forced to start Login
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.logInWithEmailAndPassword(
          email: state.email, password: state.password);
    } catch (_) {}
  }
}
