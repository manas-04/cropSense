part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitState extends HomePageState {}

class EmptyHomePageState extends HomePageState {}

class PredictLoadingState extends HomePageState {}

class PredictionErrorState extends HomePageState {
  final String error;

  const PredictionErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class PredictionSuccessfulState extends HomePageState {
  final String answer;

  const PredictionSuccessfulState(this.answer);

  @override
  List<Object> get props => [answer];
}

class LetsExploreClickedState extends HomePageState {}

class ContributeToUsButtonClickedState extends HomePageState {}

class CropRecommendationFeatureClickedState extends HomePageState {}

class PlantsIOTImageClickedState extends HomePageState {}

class IPULogoClickedState extends HomePageState {}

class DiseaseDetectionClickedState extends HomePageState {}

class ChooseFileButtonClickedState extends HomePageState {}

class FileSelectedState extends HomePageState {
  final File selectedImage;

  const FileSelectedState(this.selectedImage);

  @override
  List<Object> get props => [selectedImage.toString()];
}
