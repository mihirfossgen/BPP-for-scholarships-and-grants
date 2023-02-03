import 'dart:async';

import 'package:dsep_bpp/widgets/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import './screens/splashscreen.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:layout/layout.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'utils/colors_widget.dart';

void main() async {
  runZonedGuarded<Future<Null>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runApp(const MyApp());
  }, (e, s) {
    print(e);
  });
}

void setErrorBuilder() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    if (kDebugMode) print(errorDetails.toString());
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: const TextWidget(
            text: "Oops!",
            size: 18,
            weight: FontWeight.w800,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: const Center(
            child: TextWidget(
          text: "Oops! Something went wrong...",
        )));
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) setErrorBuilder();
    final materialTheme = ThemeData(
      //fontFamily: 'Aller',
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: primaryColor,
        barBackgroundColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        textTheme: CupertinoTextThemeData(primaryColor: whiteColor),
        brightness: Brightness.light,
        primaryContrastingColor: whiteColor,
      ),
      primarySwatch: generateMaterialColor(color: primaryColor),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
          foregroundColor: MaterialStateProperty.all(const Color(0xFF3DDC84)),
        ),
      ),
    );
    return loadApp(materialTheme);
  }

  Widget loadApp(ThemeData materialTheme) {
    return Theme(
      data: materialTheme,
      child: Layout(
        child: PlatformApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
            Locale('fa', ''),
            Locale('fr', ''),
            Locale('ja', ''),
            Locale('pt', ''),
            Locale('sk', ''),
            Locale('pl', ''),
          ],
          title: 'DESP BPP',
          home: const SplashScreen(),
          material: (_, __) => MaterialAppData(
            debugShowCheckedModeBanner: false,
            theme: materialTheme,
          ),
          cupertino: (_, __) => CupertinoAppData(
            debugShowCheckedModeBanner: false,
            theme: const CupertinoThemeData(
              primaryColor: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
