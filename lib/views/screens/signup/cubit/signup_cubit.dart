import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit(this._authRepository) : super(SignupState.initial());

  // New state : with the new value of email
  void emailChanged(String value) {
    // Here, copyWith is use to only affect new values of only necessary field
    // Each email modification -> field email get new value and status is initial
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  // New state : with the new value of password
  void passwordChanged(String value) {
    // Here, copyWith is use to only affect new values of only necessary field
    // Each password modification -> field password get new value and status is initial
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  // Ask to AuthRepository to try signup with state's informations
  Future<void> signupFormSubmitted() async {
    if (state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      await _authRepository.signup(
          email: state.email, password: state.password);
      emit(state.copyWith(status: SignupStatus.success));
    } catch (_) {}
  }
}
