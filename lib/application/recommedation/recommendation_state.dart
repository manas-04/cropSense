part of 'recommendation_bloc.dart';

abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object> get props => [];
}

class EmptyRecommendationState extends RecommendationState {}

class InitialRecommendationState extends RecommendationState {}

class CountryChangeState extends RecommendationState {
  final String countryName;

  const CountryChangeState(this.countryName);

  @override
  List<Object> get props => [countryName];
}

class CityChangeState extends RecommendationState {
  final String cityName;

  const CityChangeState(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class StateChangeState extends RecommendationState {
  final String stateName;

  const StateChangeState(this.stateName);

  @override
  List<Object> get props => [stateName];
}

class NextButtonClickedState extends RecommendationState {
  final String? countryName;
  final String? cityName;
  final String? stateName;

  const NextButtonClickedState(
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

class ChangeTabIndexState extends RecommendationState {}

class RecommendationIndexChangedState extends RecommendationState {
  final int index;

  const RecommendationIndexChangedState(this.index);

  @override
  List<Object> get props => [index];
}

class SubmitRecommendationFormClickedState extends RecommendationState {
  final String? phLevel;
  final String? rainfallLevel;
  final String? nitrgoenLevel;
  final String? phosphorusLevel;
  final String? potassiumLevel;

  const SubmitRecommendationFormClickedState({
    required this.phLevel,
    required this.rainfallLevel,
    required this.nitrgoenLevel,
    required this.phosphorusLevel,
    required this.potassiumLevel,
  });

  @override
  List<Object> get props => [
        phLevel.toString(),
        rainfallLevel.toString(),
        nitrgoenLevel.toString(),
        phosphorusLevel.toString(),
        potassiumLevel.toString(),
      ];
}

class FetchRecommendedCropLoadingState extends RecommendationState {}

class FetchRecommendedCropLoadedState extends RecommendationState {
  final RecommendationResponse crop;

  const FetchRecommendedCropLoadedState(this.crop);

  @override
  List<Object> get props => [crop];
}

class FetchRecommendedCropErrorState extends RecommendationState {
  final String error;

  const FetchRecommendedCropErrorState(this.error);

  @override
  List<Object> get props => [error];
}
