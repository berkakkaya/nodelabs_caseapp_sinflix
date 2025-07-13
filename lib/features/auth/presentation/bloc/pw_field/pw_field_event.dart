import "package:equatable/equatable.dart";

sealed class PwFieldEvent extends Equatable {
  const PwFieldEvent();

  @override
  List<Object?> get props => [];
}

class PwFieldShowEvent extends PwFieldEvent {}

class PwFieldHideEvent extends PwFieldEvent {}
