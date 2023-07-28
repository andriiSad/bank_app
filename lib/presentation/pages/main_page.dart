import 'package:bank_app/common/values/app_colors.dart';
import 'package:bank_app/logic/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:bank_app/logic/bottom_navigation/bottom_navigation_states.dart';
import 'package:bank_app/presentation/pages/home_page/home_page.dart';
import 'package:bank_app/logic/bottom_navigation/constants/bottom_nav_bar_items.dart';
import 'package:bank_app/presentation/pages/settings_page.dart';
import 'package:bank_app/presentation/pages/transactions_page.dart';
import 'package:bank_app/presentation/pages/transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BottomNavigationBarItem> bottomNavBarItems = [
    for (var item in [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.switch_access_shortcut, 'label': 'Transfer'},
      {'icon': Icons.receipt_long, 'label': 'Transactions'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ])
      BottomNavigationBarItem(
        icon: Icon(item['icon'] as IconData?),
        label: item['label'] as String?,
      ),
  ];
  void onTap(int index) {
    BottomNavbarItem navBarItem;
    switch (index) {
      case 0:
        navBarItem = BottomNavbarItem.home;
        break;
      case 1:
        navBarItem = BottomNavbarItem.transfer;
        break;
      case 2:
        navBarItem = BottomNavbarItem.transactions;
        break;
      case 3:
        navBarItem = BottomNavbarItem.settings;
        break;
      default:
        return;
    }
    BlocProvider.of<BottomNavigationCubit>(context).getNavBarItem(navBarItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          final Map<BottomNavbarItem, Widget> pageMap = {
            BottomNavbarItem.home: const HomePage(),
            BottomNavbarItem.transfer: TransferPage(),
            BottomNavbarItem.transactions: const TransactionsPage(),
            BottomNavbarItem.settings: const SettingsPage(),
          };

          return pageMap[state.navbarItem] ?? Container();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.red,
            selectedLabelStyle: TextStyle(
              color: AppColors.black.withOpacity(0.5),
            ),
            unselectedItemColor: AppColors.black.withOpacity(0.5),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: onTap,
            items: bottomNavBarItems,
          );
        },
      ),
    );
  }
}
