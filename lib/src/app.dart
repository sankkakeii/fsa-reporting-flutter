import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fsa_reporting/splash/splash.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler package

import 'settings/settings_controller.dart';

import 'login/login.dart';
import 'fsaForm/fsaform.dart';
import 'register/register.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    _requestLocationPermission(); // Call the function to request location permission
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          initialRoute: SplashScreen.routeName, // Set initial route to login page
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            Login.routeName: (context) => const Login(),
            FSAForm.routeName: (context) => const FSAForm(),
            Registration.routeName: (context) => const Registration(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  // Function to request location permission
  Future<void> _requestLocationPermission() async {
    // Check if permission is granted, if not, request it
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }
}
