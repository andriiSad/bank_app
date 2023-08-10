import 'package:flutter/material.dart';

import 'transfer_form.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: TransferForm(),
      ),
    );
  }
}
