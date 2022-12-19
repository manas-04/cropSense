import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../data/home_carousal_list.dart';
import '../helpers/size_helper.dart';

class RecommendationPageCarousal extends StatefulWidget {
  const RecommendationPageCarousal({super.key});

  @override
  State<RecommendationPageCarousal> createState() =>
      _RecommendationPageCarousalState();
}

class _RecommendationPageCarousalState
    extends State<RecommendationPageCarousal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enableInfiniteScroll: recommendedCarouselImagesList.length > 1,
          height: displayWidth(context) * 0.3,
          aspectRatio: 335 / 89,
          viewportFraction: 1,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 300),
        ),
        items: recommendedCarouselImagesList
            .map(
              (image) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: displayWidth(context) - 40,
                  height: (displayWidth(context) - 40) * 89 / 335,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade300,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: displayWidth(context) - 40,
                      height: (displayWidth(context) - 40) * 89 / 335,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
