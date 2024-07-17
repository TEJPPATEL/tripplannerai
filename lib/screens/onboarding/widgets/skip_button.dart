import 'package:flutter/material.dart';
import 'package:tripplannerai/utilites/screen_route.dart';
import 'package:tripplannerai/utilites/storage_keys.dart';

import '../../../services/shared_preference_service.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: TextButton(
        style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
        child: const Text(
          'Skip',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () async {
          await SharedPreferencesService()
              .addBoolToSharePreferences(StorageKeys.isFirstLunch, false);
          Navigator.of(context).pushReplacementNamed(ScreenRoute.login);
        },
      ),
    );
  }
}
