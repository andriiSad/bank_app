import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/app_colors.dart';
import '../../common/values/app_layout.dart';
import '../../common/values/app_styles.dart';
import '../../logic/app/bloc/app_bloc.dart';
import '../../logic/app/bloc/app_events.dart';
import '../../logic/bottom_navigation/bottom_navigation_cubit.dart';
import '../../logic/bottom_navigation/constants/bottom_nav_bar_items.dart';
import '../widgets/app_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<BottomNavigationCubit>(context)
                        .getNavBarItem(BottomNavbarItem.home);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Settings',
                      style: AppStyles.textStyle.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            Center(
              //TODO: show loading or default user when the photoUrl is not aviable
              child: CircleAvatar(
                radius: AppLayout.getWidth(60),
                backgroundImage: appBloc.state.user.photoUrl != null
                    ? NetworkImage(appBloc.state.user.photoUrl!)
                        as ImageProvider<Object>
                    : const AssetImage('assets/images/users/default_user.png'),
                backgroundColor: AppColors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: AppLayout.getWidth(15),
                right: AppLayout.getWidth(15),
              ),
              child: AppButton(
                text: 'Log out',
                callback: () {
                  context
                      .read<BottomNavigationCubit>()
                      .getNavBarItem(BottomNavbarItem.home);
                  appBloc.add(const AppLogoutRequested());
                },
                backGroundColor: AppColors.black,
                textColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
