import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/models/user_model.dart';
import 'package:brain_saver_flutter/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _userSubscription;

  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        // At creation of Bloc : auto relog with current user logged when leaving app last time
        super(authRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authRepository.currentUser)
            : const AppState.unauthenticated()) {
    // Link Events to Functions
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);

    // On each modification of the user in AuhtRepository, AppUserChanged event is generated
    _userSubscription = _authRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    // Executed when user change
    //   --> If user is not empty -> state setted to Logged State
    //   --> If not -> state setted to inital state (empty)
    emit(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    // We don't need to wait any response of Firebase so we unwaited end of Firebase SignOut
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    // At end of the bloc, we destroy the stream linked to user's modification
    _userSubscription?.cancel();
    return super.close();
  }
}
