import 'package:equatable/equatable.dart';

import '../../../models/user.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
  welcome,
}

final class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user) : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.welcome() : this._(status: AppStatus.welcome);

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
