import "package:equatable/equatable.dart";

sealed class HomeTabChangeEvent {}

class HomeDiscoverTabTapped extends HomeTabChangeEvent {}

class ProfileTabTapped extends HomeTabChangeEvent {}

class TabState extends Equatable {
  final int selectedIndex;
  const TabState({this.selectedIndex = 0})
    : assert(selectedIndex >= 0, "Selected index must be non-negative");

  @override
  List<Object> get props => [selectedIndex];
}
