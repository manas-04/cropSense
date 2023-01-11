import 'package:auto_size_text/auto_size_text.dart';
import 'package:crop_sense/application/home_page/home_page_bloc.dart';
import 'package:crop_sense/presentation/features/feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/color_helper.dart';
import '../helpers/font_style_helper.dart';

class FeaturePage extends StatefulWidget {
  const FeaturePage({super.key});

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AutoSizeText(
          'Features',
          style: kHeading22.copyWith(
            color: backgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          FeatureCard(
            title: "Plant Disease Detection",
            subTitle:
                "This feature allows you to upload a photo of a plant or plant part and get a diagnosis of any potential diseases affecting the plant.",
            image: "assets/images/diseasedPlant.png",
            ontap: () {
              context.read<HomePageBloc>().add(DiseaseDetectionClickedEvent());
            },
          ),
          FeatureCard(
            title: "Plant Recommendation",
            subTitle:
                "This feature allows you to get recommendations for suitable crops to grow in their area based on the local climate and soil conditions.",
            ontap: () {
              context
                  .read<HomePageBloc>()
                  .add(CropRecommendationFeatureClickedEvent());
            },
            image: "assets/images/crop.png",
          ),
          FeatureCard(
            title: "Contribute To Us",
            subTitle:
                "This feature allows you to contribute their own photos and knowledge of plant diseases to the CropSense database, helping to improve the accuracy of the app's diagnoses.",
            ontap: () {
              context
                  .read<HomePageBloc>()
                  .add(ContributeToUsButtonClickedEvent());
            },
            image: "assets/images/plants.png",
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
