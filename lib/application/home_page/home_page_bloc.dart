import 'package:bloc/bloc.dart';
import 'package:crop_sense/application/helpers/event.dart';
import 'package:equatable/equatable.dart';

part 'home_page_state.dart';
part 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(HomePageState initstate) : super(initstate) {
    on<LetsExploreClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(LetsExploreClickedState());
    });
    on<ContributeToUsButtonClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(ContributeToUsButtonClickedState());
    });
    on<CropRecommendationFeatureClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(CropRecommendationFeatureClickedState());
    });
    on<PlantsIOTImageClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(PlantsIOTImageClickedState());
    });
    on<IPULogoClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(IPULogoClickedState());
    });
  }
}
