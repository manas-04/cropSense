import 'package:bloc/bloc.dart';
import 'package:crop_sense/application/helpers/event.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_state.dart';
part 'recommendation_event.dart';

class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  RecommendationBloc(RecommendationState initstate) : super(initstate) {
    on<RecommendationIndexChangedEvent>((event, emit) {
      emit(RecommendationIndexChangedState(event.index));
    });
    on<CountryChangeEvent>((event, emit) {
      emit(EmptyRecommendationState());
      emit(CountryChangeState(event.countryName));
    });
    on<StateChangeEvent>((event, emit) {
      emit(EmptyRecommendationState());
      emit(StateChangeState(event.stateName));
    });
    on<CityChangeEvent>((event, emit) {
      emit(EmptyRecommendationState());
      emit(CityChangeState(event.cityName));
    });
    on<NextButtonClickedEvent>((event, emit) {
      emit(EmptyRecommendationState());
      emit(NextButtonClickedState(
        event.countryName,
        event.cityName,
        event.stateName,
      ));
    });
    on<ChangeTabIndexEvent>((event, emit) {
      emit(EmptyRecommendationState());
      emit(ChangeTabIndexState());
    });
    on<SubmitRecommendationFormClickedEvent>((event, emit) {
      emit(EmptyRecommendationState());
      emit(SubmitRecommendationFormClickedState(
        humidtyLevel: event.humidtyLevel,
        nitrgoenLevel: event.nitrgoenLevel,
        phLevel: event.phLevel,
        phosphorusLevel: event.phosphorusLevel,
        potassiumLevel: event.potassiumLevel,
      ));
    });
    on<SubmitDataToBackendEvent>((event, emit) {
      //Todo
    });
  }
}
