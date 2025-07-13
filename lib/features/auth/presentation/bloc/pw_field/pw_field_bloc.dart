import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/pw_field/pw_field_event.dart";
import "package:nodelabs_caseapp_sinflix/features/auth/presentation/bloc/pw_field/pw_field_state.dart";

class PwFieldBloc extends Bloc<PwFieldEvent, PwFieldState> {
  PwFieldBloc() : super(PwFieldHidden()) {
    on<PwFieldEvent>((event, emit) {
      if (event is PwFieldShowEvent) {
        emit(PwFieldShown());
      } else if (event is PwFieldHideEvent) {
        emit(PwFieldHidden());
      }
    });
  }
}
