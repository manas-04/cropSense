import 'package:crop_sense/presentation/features/features_page.dart';
import 'package:crop_sense/routes/routes.dart';
import 'package:get/route_manager.dart';

import '../main_page.dart';
import '../presentation/get_crop_recommendations/recommendations.dart';

class RouteGenerator {
  static final pages = [
    GetPage(
      name: Routes.app,
      page: () => const MainPage(),
    ),
    GetPage(
      name: Routes.cropRecommendation,
      page: () => const CropRecommendationsPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.featuresPage,
      page: () => const FeaturePage(),
      transition: Transition.cupertino,
    ),
  ];
}
