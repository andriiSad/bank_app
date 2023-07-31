import 'package:bloc/bloc.dart';

import 'bottom_navigation_states.dart';
import 'constants/bottom_nav_bar_items.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const BottomNavigationState(BottomNavbarItem.home, 0));

  void getNavBarItem(BottomNavbarItem navbarItem) {
    switch (navbarItem) {
      case BottomNavbarItem.home:
        emit(const BottomNavigationState(BottomNavbarItem.home, 0));
      case BottomNavbarItem.transfer:
        emit(const BottomNavigationState(BottomNavbarItem.transfer, 1));
      case BottomNavbarItem.transactions:
        emit(const BottomNavigationState(BottomNavbarItem.transactions, 2));
      case BottomNavbarItem.settings:
        emit(const BottomNavigationState(BottomNavbarItem.settings, 3));
    }
  }
}
