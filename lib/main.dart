import 'package:flutter/material.dart';
import 'package:tripplannerai/screens/create_trip_plan_screen.dart';
import 'package:tripplannerai/screens/onboarding/onboarding_screen.dart';
import 'package:tripplannerai/screens/splash_screen.dart';
import 'package:tripplannerai/utilites/screen_route.dart';

import 'utilites/helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isFirstLunchApplication = await isFirstLunchApp();
  runApp(MyApp(isFirstLunch: isFirstLunchApplication));
}

class MyApp extends StatelessWidget {
  final bool isFirstLunch;
  const MyApp({super.key, required this.isFirstLunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.black, primary: Colors.black)),
        title: 'DesiMeals',
        routes: {
          // ScreenRoute.emptyRoute: (context) => CreateTripPlanScreen(),
          ScreenRoute.splash: (_) => const SplashsScreen(),
          ScreenRoute.onBoard: (_) => OnBoardingScreen(),
          ScreenRoute.createTripPlan: (_) => CreateTripPlanScreen(),
          // ScreenRoute.itineraryDetails: (_) => const ItineraryDetailsScreen()
        },
        initialRoute: isFirstLunch ? ScreenRoute.onBoard : ScreenRoute.splash);
  }
}
