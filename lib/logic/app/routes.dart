import 'package:bank_app/presentation/pages/login_page/login_page.dart';
import 'package:bank_app/presentation/pages/main_page.dart';
import 'package:bank_app/presentation/pages/welcome_page.dart';
import 'package:flutter/widgets.dart';

import 'bloc/app_states.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [MainPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.welcome:
      return [WelcomePage.page()];
  }
}
