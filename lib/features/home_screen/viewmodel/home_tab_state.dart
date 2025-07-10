import "package:equatable/equatable.dart";

class TabState extends Equatable {
  final int selectedIndex;
  const TabState({this.selectedIndex = 0})
    : assert(selectedIndex >= 0, "Selected index must be non-negative");

  @override
  List<Object> get props => [selectedIndex];
}
