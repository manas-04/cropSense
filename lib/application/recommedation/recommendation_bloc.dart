import 'package:bloc/bloc.dart';
import 'package:crop_sense/application/helpers/event.dart';
import 'package:crop_sense/domain/recommendation/recommendation_response.dart';
import 'package:crop_sense/infra/api_repository/main_api_respository.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'recommendation_state.dart';
part 'recommendation_event.dart';

class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  RecommendationBloc(RecommendationState initstate) : super(initstate) {
    final MainApiRepository apiRepository = MainApiRepository();

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
        rainfallLevel: event.rainfallLevel,
        nitrgoenLevel: event.nitrgoenLevel,
        phLevel: event.phLevel,
        phosphorusLevel: event.phosphorusLevel,
        potassiumLevel: event.potassiumLevel,
      ));
    });
    on<SubmitDataToBackendEvent>((event, emit) async {
      emit(FetchRecommendedCropLoadingState());
      int N = int.parse(event.nitrgoenLevel);
      int P = int.parse(event.phosphorusLevel);
      int K = int.parse(event.potassiumLevel);
      double rainfall = double.parse(event.rainfallLevel);
      String city = event.cityName.toLowerCase();
      double ph = double.parse(event.phLevel);

      try {
        final RecommendationResponse response =
            await apiRepository.getRecommededCrop(
          n: N,
          p: P,
          k: K,
          rainfall: rainfall,
          city: city,
          ph: ph,
        );
        Logger().d('Dataaaaaaa $response');
        emit(FetchRecommendedCropLoadedState(response));
      } catch (e) {
        emit(FetchRecommendedCropErrorState(e.toString()));
      }

      // example - "{prediction: mango}"
    });
  }
}
