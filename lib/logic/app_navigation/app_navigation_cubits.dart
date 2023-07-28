import 'package:bank_app/logic/app_navigation/app_navigation_states.dart';
import 'package:bloc/bloc.dart';

class AppNavigationCubits extends Cubit<AppNavigationStates> {
  AppNavigationCubits() : super(InitState()) {
    emit(WelcomeState());
  }

  goHome() async {
    emit(LoadingState());
    // await Future.delayed(const Duration(seconds: 2));
    emit(MainState());
  }

  goWelcome() {
    emit(WelcomeState());
  }
}
