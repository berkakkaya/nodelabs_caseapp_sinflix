import "package:equatable/equatable.dart";

sealed class PwFieldState extends Equatable {
  const PwFieldState();

  @override
  List<Object?> get props => [];
}

class PwFieldShown extends PwFieldState {}

class PwFieldHidden extends PwFieldState {}
