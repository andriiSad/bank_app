import 'package:bank_app/logic/app_navigation/app_navigation_cubit_logics.dart';
import 'package:bank_app/logic/app_navigation/app_navigation_cubits.dart';
import 'package:bank_app/logic/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppNavigationCubits(),
          ),
          BlocProvider(
            create: (context) => BottomNavigationCubit(),
          ),
        ],
        child: const AppNavigationCubitLogics(),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
