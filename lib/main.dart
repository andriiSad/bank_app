import 'package:bank_app/cubit/app_cubit_logics.dart';
import 'package:bank_app/cubit/app_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AppCubits(),
        child: const AppCubitLogics(),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
