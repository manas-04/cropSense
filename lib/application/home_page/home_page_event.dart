part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Event {
  const HomePageEvent();
}

class LetsExploreClickedEvent extends HomePageEvent {}

class ContributeToUsButtonClickedEvent extends HomePageEvent {}

class CropRecommendationFeatureClickedEvent extends HomePageEvent {}

class PlantsIOTImageClickedEvent extends HomePageEvent {}

class IPULogoClickedEvent extends HomePageEvent {}

class DiseaseDetectionClickedEvent extends HomePageEvent {}

class ChooseFileButtonClickedEvent extends HomePageEvent {}

class FileSelectedEvent extends HomePageEvent {
  final File selectedImage;

  const FileSelectedEvent(this.selectedImage);

  @override
  List<Object> get props => [selectedImage.toString()];
}

class PredictClickedEvent extends HomePageEvent {
  final File selectedImage;

  const PredictClickedEvent(this.selectedImage);

  @override
  List<Object> get props => [selectedImage.toString()];
}
