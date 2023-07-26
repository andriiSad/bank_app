import 'package:bank_app/cubit/app_cubits.dart';
import 'package:bank_app/cubit/app_states.dart';
import 'package:bank_app/pages/main_page.dart';
import 'package:bank_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
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
