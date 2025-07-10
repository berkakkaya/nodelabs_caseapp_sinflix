import "package:equatable/equatable.dart";

sealed class HomeTabChangeEvent extends Equatable {}

class HomeDiscoverTabTapped extends HomeTabChangeEvent {
  @override
  List<Object> get props => [];
}

class ProfileTabTapped extends HomeTabChangeEvent {
  @override
  List<Object> get props => [];
}
