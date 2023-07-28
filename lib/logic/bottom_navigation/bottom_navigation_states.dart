import 'package:bank_app/logic/bottom_navigation/constants/bottom_nav_bar_items.dart';
import 'package:equatable/equatable.dart';

class BottomNavigationState extends Equatable {
  final BottomNavbarItem navbarItem;
  final int index;

  const BottomNavigationState(
    this.navbarItem,
    this.index,
  );

  @override
  List<Object> get props => [navbarItem, index];
}
