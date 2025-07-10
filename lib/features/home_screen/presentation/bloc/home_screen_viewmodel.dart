import "package:flutter_bloc/flutter_bloc.dart";
import "package:nodelabs_caseapp_sinflix/features/home_screen/presentation/bloc/events.dart";
import "home_tab_state.dart";

class HomeScreenViewModel extends Bloc<HomeTabChangeEvent, TabState> {
  HomeScreenViewModel() : super(const TabState()) {
    on<HomeDiscoverTabTapped>((event, emit) {
      emit(TabState(selectedIndex: 0));
    });
    on<ProfileTabTapped>((event, emit) async {
      emit(TabState(selectedIndex: 1));
    });
  }
}
