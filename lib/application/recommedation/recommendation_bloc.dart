import 'package:bloc/bloc.dart';
import 'package:crop_sense/application/helpers/event.dart';
import 'package:dio/dio.dart';
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
    on<SubmitDataToBackendEvent>((event, emit) async{
      //Todo
      var dio = Dio();

      int N = int.parse(event.nitrgoenLevel);
      int P = int.parse(event.phosphorusLevel);
      int K = int.parse(event.potassiumLevel);
      double rainfall = double.parse(event.humidtyLevel);
      String city = event.cityName.toLowerCase();
      double ph = double.parse(event.phLevel);

      var response = await dio.get(
          "https://minor-project-server.onrender.com/crop-predict",
          queryParameters: {
            "N": N,
            "P": P,
            "K": K,
            "ph": ph,
            "rainfall": rainfall,
            "city": city,
          },
      );

      print("${response.data}");
      // example - "{prediction: mango}"
    });
  }
}
