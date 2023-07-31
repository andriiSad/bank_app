import '../../../models/user.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

final class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);

  final User user;
}

final class GetStarted extends AppEvent {
  const GetStarted();
}
