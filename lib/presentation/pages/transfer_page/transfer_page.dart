import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/transfer/transfer_cubit.dart';
import '../../../repository/firestore_repository.dart';
import 'transfer_form.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => TransferCubit(
            context.read<FirestoreRepository>(),
          ),
          child: const TransferForm(),
        ),
      ),
    );
  }
}
