import 'package:crop_sense/presentation/common/Widgets/default_text_box.dart';
import 'package:flutter/material.dart';

import '../helpers/color_helper.dart';
import '../helpers/size_helper.dart';

class CropRecommendationsPage extends StatefulWidget {
  const CropRecommendationsPage({Key? key}) : super(key: key);

  @override
  State<CropRecommendationsPage> createState() =>
      _CropRecommendationsPageState();
}

class _CropRecommendationsPageState extends State<CropRecommendationsPage> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();
  final TextEditingController _phLevelController = TextEditingController();
  final TextEditingController _nitrogenController = TextEditingController();
  final TextEditingController _phosphorusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor2.withOpacity(0.8),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: displayWidth(context) * 0.1,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextBox(
                key: const ValueKey("City"),
                hintText: 'City',
                labelText: 'City',
                icon: const Icon(
                  Icons.location_city_rounded,
                  color: primaryColor2,
                ),
                textEditingController: _cityController,
                textInputType: TextInputType.number,
                obscureText: false,
                enabled: true,
                backgroundColor: primaryColor5,
              ),
              DefaultTextBox(
                key: const ValueKey("phLevel"),
                hintText: 'pH Level of Soil',
                labelText: 'pH Level',
                icon: const Icon(
                  Icons.nature_rounded,
                  color: primaryColor2,
                ),
                textEditingController: _phLevelController,
                textInputType: TextInputType.number,
                obscureText: false,
                enabled: true,
                backgroundColor: primaryColor5,
              ),
              DefaultTextBox(
                key: const ValueKey("Humidity"),
                hintText: 'Humidity',
                labelText: 'Humidity',
                icon: const Icon(
                  Icons.water_drop_rounded,
                  color: primaryColor2,
                ),
                textEditingController: _humidityController,
                textInputType: TextInputType.number,
                obscureText: false,
                enabled: true,
                backgroundColor: primaryColor5,
              ),
              DefaultTextBox(
                key: const ValueKey("NitrogenLevel"),
                hintText: 'Nitrogen Level',
                labelText: 'Nitrogen Level',
                icon: const Icon(
                  Icons.gas_meter_rounded,
                  color: primaryColor2,
                ),
                textEditingController: _nitrogenController,
                textInputType: TextInputType.number,
                obscureText: false,
                enabled: true,
                backgroundColor: primaryColor5,
              ),
              DefaultTextBox(
                key: const ValueKey("Phosphorus Level"),
                hintText: 'Phosphorus Level',
                labelText: 'Phosphorus Level',
                icon: const Icon(
                  Icons.gas_meter_rounded,
                  color: primaryColor2,
                ),
                textEditingController: _phosphorusController,
                textInputType: TextInputType.number,
                obscureText: false,
                enabled: true,
                backgroundColor: primaryColor5,
              ),
              DefaultTextBox(
                key: const ValueKey("Potassium Level"),
                hintText: 'Potassium Level',
                labelText: 'Potassium Level',
                icon: const Icon(
                  Icons.gas_meter_rounded,
                  color: primaryColor2,
                ),
                textEditingController: _phosphorusController,
                textInputType: TextInputType.number,
                obscureText: false,
                enabled: true,
                backgroundColor: primaryColor5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
