part of 'app_bloc.dart';

// Differents authentification's status
enum AppStatus { authenticated, unauthenticated }

class AppState extends Equatable {
  final AppStatus status;
  final User user;

  // Constructor of App state
  const AppState._({required this.status, this.user = User.empty});

  // At login, modification fo status and user's information is saved in state (id, etc.)
  const AppState.authenticated(User user)
      : this._(
          status: AppStatus.authenticated,
          user: user,
        );

  // At logout -> modification of status (and user is set to empty too : default value in constructor)
  const AppState.unauthenticated()
      : this._(
          status: AppStatus.unauthenticated,
        );

  @override
  List<Object> get props => [status, user];
}
