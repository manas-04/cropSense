part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Event {
  const HomePageEvent();
}

class LetsExploreClickedEvent extends HomePageEvent {}

class ContributeToUsButtonClickedEvent extends HomePageEvent {}

class CropRecommendationClickedEvent extends HomePageEvent {}

class PlantsIOTImageClickedEvent extends HomePageEvent {}

class IPULogoClickedEvent extends HomePageEvent {}
