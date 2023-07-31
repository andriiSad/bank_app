import 'package:equatable/equatable.dart';

import 'constants/bottom_nav_bar_items.dart';

class BottomNavigationState extends Equatable {
  const BottomNavigationState(
    this.navbarItem,
    this.index,
  );
  final BottomNavbarItem navbarItem;
  final int index;

  @override
  List<Object> get props => [navbarItem, index];
}
