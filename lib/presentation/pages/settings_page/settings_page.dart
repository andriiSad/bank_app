import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/edit/edit_cubit.dart';
import '../../../repository/authentication_repository.dart';
import '../../../repository/firestore_repository.dart';
import 'settings_form.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: BlocProvider<EditCubit>(
            create: (_) => EditCubit(
              context.read<FirestoreRepository>(),
              context.read<AuthenticationRepository>(),
            ),
            child: const SettingsForm(),
          ),
        ),
      ),
    );
  }
}
