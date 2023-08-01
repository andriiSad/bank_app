import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/values/app_layout.dart';
import '../../../logic/sign_up/sign_up_cubit.dart';
import '../../../repository/authentication_repository.dart';
import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = AppLayout.getSize(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/light_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: BlocProvider<SignUpCubit>(
            create: (_) =>
                SignUpCubit(context.read<AuthenticationRepository>()),
            child: const SignUpForm(),
          ),
        ),
      ),
    );
  }
}
