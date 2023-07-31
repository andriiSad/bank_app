import 'package:bank_app/common/values/app_colors.dart';
import 'package:bank_app/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/app_layout.dart';
import '../../logic/app/bloc/app_bloc.dart';
import '../../logic/app/bloc/app_events.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppLayout.getWidth(15),
              right: AppLayout.getWidth(15),
            ),
            child: AppButton(
              text: 'Log out',
              callback: () {
                context.read<AppBloc>().add(const AppLogoutRequested());
              },
              backGroundColor: AppColors.black,
              textColor: AppColors.white,
            ),
          ),
        ],
      ),
    ));
  }
}
