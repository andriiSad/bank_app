import 'package:bank_app/common/values/app_colors.dart';
import 'package:bank_app/pages/home_page/home_page.dart';
import 'package:bank_app/pages/settings_page.dart';
import 'package:bank_app/pages/transactions_page.dart';
import 'package:bank_app/pages/transfer_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const TransferPage(),
    const TransactionsPage(),
    const SettingsPage(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.red,
        selectedLabelStyle: TextStyle(
          color: AppColors.black.withOpacity(0.5),
        ),
        unselectedItemColor: AppColors.black.withOpacity(0.5),
        // showUnselectedLabels: false,
        // showSelectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.switch_access_shortcut),
            label: 'Transfer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
