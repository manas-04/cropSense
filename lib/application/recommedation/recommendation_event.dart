part of 'recommendation_bloc.dart';

abstract class RecommendationEvent extends Event {
  const RecommendationEvent();
}

class RecommendationIndexChangedEvent extends RecommendationEvent {
  final int index;

  const RecommendationIndexChangedEvent(this.index);
}

class CountryChangeEvent extends RecommendationEvent {
  final String countryName;

  const CountryChangeEvent(this.countryName);

  @override
  List<Object> get props => [countryName];
}

class StateChangeEvent extends RecommendationEvent {
  final String stateName;

  const StateChangeEvent(this.stateName);
  @override
  List<Object> get props => [stateName];
}

class CityChangeEvent extends RecommendationEvent {
  final String cityName;

  const CityChangeEvent(this.cityName);
  @override
  List<Object> get props => [cityName];
}

class NextButtonClickedEvent extends RecommendationEvent {
  final String? countryName;
  final String? cityName;
  final String? stateName;

  const NextButtonClickedEvent(
    this.countryName,
    this.cityName,
    this.stateName,
  );

  @override
  List<Object> get props => [
        countryName.toString(),
        cityName.toString(),
        stateName.toString(),
      ];
}

class ChangeTabIndexEvent extends RecommendationEvent {}

class SubmitRecommendationFormClickedEvent extends RecommendationEvent {
  final String? phLevel;
  final String? humidtyLevel;
  final String? nitrgoenLevel;
  final String? phosphorusLevel;
  final String? potassiumLevel;

  const SubmitRecommendationFormClickedEvent({
    required this.phLevel,
    required this.humidtyLevel,
    required this.nitrgoenLevel,
    required this.phosphorusLevel,
    required this.potassiumLevel,
  });

  @override
  List<Object> get props => [
        phLevel.toString(),
        humidtyLevel.toString(),
        nitrgoenLevel.toString(),
        phosphorusLevel.toString(),
        potassiumLevel.toString(),
      ];
}

class SubmitDataToBackendEvent extends RecommendationEvent {
  final String countryName;
  final String cityName;
  final String stateName;
  final String phLevel;
  final String humidtyLevel;
  final String nitrgoenLevel;
  final String phosphorusLevel;
  final String potassiumLevel;

  const SubmitDataToBackendEvent({
    required this.countryName,
    required this.stateName,
    required this.cityName,
    required this.phLevel,
    required this.humidtyLevel,
    required this.nitrgoenLevel,
    required this.phosphorusLevel,
    required this.potassiumLevel,
  });

  @override
  List<Object> get props => [
        countryName,
        stateName,
        cityName,
        phLevel,
        humidtyLevel,
        nitrgoenLevel,
        phosphorusLevel,
        potassiumLevel,
      ];
}
