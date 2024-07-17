import 'package:flutter/material.dart';
import 'package:tripplannerai/utilites/screen_route.dart';

class SplashsScreen extends StatefulWidget {
  const SplashsScreen({super.key});

  @override
  State<SplashsScreen> createState() => _SplashsScreenState();
}

class _SplashsScreenState extends State<SplashsScreen> {

  @override
  void initState() {

    super.initState();  
    Future.delayed(const Duration(seconds: 3),()=>{
      Navigator.pushReplacementNamed(context, ScreenRoute.createTripPlan) 
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              color: Colors.black,
              child: const Text(
                'Travel Planner',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  letterSpacing: 2.0
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: const Text(
                'AI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50,
                  letterSpacing: 2.0
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
