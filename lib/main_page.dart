import 'package:auto_size_text/auto_size_text.dart';
import 'package:crop_sense/application/home_page/home_page_bloc.dart';
import 'package:crop_sense/presentation/helpers/color_helper.dart';
import 'package:crop_sense/presentation/helpers/size_helper.dart';
import 'package:crop_sense/presentation/home/home_page.dart';
import 'package:crop_sense/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'presentation/helpers/font_style_helper.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: AutoSizeText(
          'Crop Sense',
          style: kHeading22.copyWith(
            color: backgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is ContributeToUsButtonClickedState) {
            Fluttertoast.showToast(
              msg: "Work under progress!!",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.grey.shade300,
              textColor: primaryColor2,
            );
          }
          if (state is CropRecommendationClickedState) {
            Navigator.pushNamed(context, Routes.cropRecommendation);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: displayHeight(context) * 0.03,
                  horizontal: 30.0,
                ),
                child: const HomePage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
