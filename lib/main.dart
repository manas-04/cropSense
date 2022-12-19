import 'package:crop_sense/application/home_page/home_page_bloc.dart';
import 'package:crop_sense/routes/routes.generator.dart';
import 'package:crop_sense/simple_bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'presentation/helpers/color_helper.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageBloc(
            HomePageInitState(),
          ),
        ),
      ],
      child: Listener(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: RouteGenerator.pages,
          initialRoute: "/",
          title: 'CropSense',
          theme: ThemeData(
            colorScheme: ColorScheme.light(
              secondary: primaryColor2.withOpacity(0.2),
              primary: primaryColor2,
              brightness: Brightness.light,
            ),
            textSelectionTheme: const TextSelectionThemeData().copyWith(
              cursorColor: primaryColor2,
            ),
          ),
        ),
      ),
    );
  }
}
