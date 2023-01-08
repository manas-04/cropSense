import 'package:auto_size_text/auto_size_text.dart';
import 'package:crop_sense/presentation/features/feature_card.dart';
import 'package:crop_sense/presentation/helpers/size_helper.dart';
import 'package:flutter/material.dart';

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
          FeatureCard(
            title: "Plant Disease Detection",
            subTitle:
                "This feature allows you to upload a photo of a plant or plant part and get a diagnosis of any potential diseases affecting the plant.",
            image: "assets/images/diseasedPlant.png",
            ontap: () {},
          ),
          FeatureCard(
            title: "Plant Recommendation",
            subTitle:
                "This feature allows you to get recommendations for suitable crops to grow in their area based on the local climate and soil conditions.",
            ontap: () {},
            image: "assets/images/crop.png",
          ),
          FeatureCard(
            title: "Contribute To Us",
            subTitle:
                "This feature allows you to contribute their own photos and knowledge of plant diseases to the CropSense database, helping to improve the accuracy of the app's diagnoses.",
            ontap: () {},
            image: "assets/images/plants.png",
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
