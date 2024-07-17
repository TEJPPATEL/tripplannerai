import 'package:flutter/material.dart';
import 'package:tripplannerai/screens/onboarding/widgets/onboard_content.dart';
import 'package:tripplannerai/screens/onboarding/widgets/skip_button.dart';
import 'package:tripplannerai/services/shared_preference_service.dart';
import 'package:tripplannerai/utilites/app_images.dart';
import 'package:tripplannerai/utilites/screen_route.dart';
import 'package:tripplannerai/utilites/storage_keys.dart';
import 'package:tripplannerai/utilites/text_const.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _totalItem = 3;

  final List<Map<String, dynamic>> _onboardScreens = [
    {
      'imageURL': AppImages.onboardImage1,
      'title': TextConstant.onboardTitle1,
      'desc': TextConstant.onboardDesc1
    },
    {
      'imageURL': AppImages.onboardImage2,
      'title': TextConstant.onboardTitle2,
      'desc': TextConstant.onboardDesc2
    },
    {
      'imageURL': AppImages.onboardImage3,
      'title': TextConstant.onboardTitle3,
      'desc': TextConstant.onboardDesc3
    }
  ];

  int _activeScreenIndex = 0;
  final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SkipButton(),
              Expanded(
                child: PageView.builder(
                    itemBuilder: (context, idx) {
                      return OnboardContent(
                        title: _onboardScreens[idx]['title'],
                        desc: _onboardScreens[idx]['desc'],
                        imageURL: _onboardScreens[idx]['imageURL'],
                      );
                    },
                    itemCount: _onboardScreens.length,
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        _activeScreenIndex = value;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DotIndicator(
                      totalItem: _totalItem,
                      activeScreenIndex: _activeScreenIndex),
                  IconButton(
                    color: Colors.white,
                    splashColor: Colors.red,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black)),
                    onPressed: _onNextIconClicked,
                    iconSize: 40.0,
                    icon: const Icon(Icons.arrow_right_alt_rounded),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onNextIconClicked() async {
    if (_activeScreenIndex < 2) {
      _pageController.nextPage(
          duration: const Duration(microseconds: 300), curve: Curves.ease);
    } else {
      await SharedPreferencesService()
          .addBoolToSharePreferences(StorageKeys.isFirstLunch, false);
      Navigator.of(context).pushReplacementNamed(ScreenRoute.createTripPlan);
    }
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required int totalItem,
    required int activeScreenIndex,
  })  : _totalItem = totalItem,
        _activeScreenIndex = activeScreenIndex;

  final int _totalItem;
  final int _activeScreenIndex;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...List.generate(
        (_totalItem),
        (idx) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              // color:Colors.black,
              height: 10,
              width: idx == _activeScreenIndex ? 25 : 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: idx == _activeScreenIndex
                      ? Colors.black
                      : Colors.black.withOpacity(0.2)),
            ),
          );
        },
      ),
    ]);
  }
}
