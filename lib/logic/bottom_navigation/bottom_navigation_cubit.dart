import 'package:bank_app/logic/bottom_navigation/bottom_navigation_states.dart';
import 'package:bank_app/logic/bottom_navigation/constants/bottom_nav_bar_items.dart';
import 'package:bloc/bloc.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(const BottomNavigationState(BottomNavbarItem.home, 0));

  void getNavBarItem(BottomNavbarItem navbarItem) {
    switch (navbarItem) {
      case BottomNavbarItem.home:
        emit(const BottomNavigationState(BottomNavbarItem.home, 0));
        break;
      case BottomNavbarItem.transfer:
        emit(const BottomNavigationState(BottomNavbarItem.transfer, 1));
        break;
      case BottomNavbarItem.transactions:
        emit(const BottomNavigationState(BottomNavbarItem.transactions, 2));
        break;
      case BottomNavbarItem.settings:
        emit(const BottomNavigationState(BottomNavbarItem.settings, 3));
        break;
    }
  }
}
