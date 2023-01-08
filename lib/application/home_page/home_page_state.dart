part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitState extends HomePageState {}

class EmptyHomePageState extends HomePageState {}

class LetsExploreClickedState extends HomePageState {}

class ContributeToUsButtonClickedState extends HomePageState {}

class CropRecommendationFeatureClickedState extends HomePageState {}

class PlantsIOTImageClickedState extends HomePageState {}

class IPULogoClickedState extends HomePageState {}
