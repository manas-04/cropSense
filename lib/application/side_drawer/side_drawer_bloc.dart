import 'package:bloc/bloc.dart';
import 'package:crop_sense/application/helpers/event.dart';
import 'package:equatable/equatable.dart';

part 'side_drawer_state.dart';
part 'side_drawer_event.dart';

class SideDrawerBloc extends Bloc<SideDrawerEvent, SideDrawerState> {
  SideDrawerBloc(SideDrawerState initstate) : super(initstate) {
    on<ResourceTileClickedEvent>((event, emit) {
      emit(EmptySideDrawerState());
      emit(ResourceTileClickedState());
    });
    on<GalleryTileClickedEvent>((event, emit) {
      emit(EmptySideDrawerState());
      emit(GalleryTileClickedState());
    });
    on<AboutUsTileClickedEvent>((event, emit) {
      emit(EmptySideDrawerState());
      emit(AboutUsTileClickedState());
    });
    on<ProjectTeamTileClickedEvent>((event, emit) {
      emit(EmptySideDrawerState());
      emit(ProjectTeamTileClickedState());
    });
    on<ContactUsTileClickedEvent>((event, emit) {
      emit(EmptySideDrawerState());
      emit(ContactUsTileClickedState());
    });
  }
}
