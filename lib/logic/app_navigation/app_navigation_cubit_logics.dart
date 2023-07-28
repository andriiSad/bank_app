import 'package:bank_app/logic/app_navigation/app_navigation_cubits.dart';
import 'package:bank_app/logic/app_navigation/app_navigation_states.dart';
import 'package:bank_app/presentation/pages/main_page.dart';
import 'package:bank_app/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigationCubitLogics extends StatefulWidget {
  const AppNavigationCubitLogics({super.key});

  @override
  State<AppNavigationCubitLogics> createState() =>
      _AppNavigationCubitLogicsState();
}

class _AppNavigationCubitLogicsState extends State<AppNavigationCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppNavigationCubits, AppNavigationStates>(
        builder: (context, state) {
          if (state is WelcomeState) {
            return const WelcomePage();
          }
          if (state is MainState) {
            return const MainPage();
          }
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
