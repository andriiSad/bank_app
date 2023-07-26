import 'package:bank_app/cubit/app_states.dart';
import 'package:bloc/bloc.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits() : super(InitState()) {
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
