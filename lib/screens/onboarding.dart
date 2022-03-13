import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => Login())));
        },
        finishCallback: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => Login())));
        },
      ),
    );
  }

  final pages = [
    new PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'assets/01.jpg',
        title: 'Screen 1',
        body: 'Share your ideas with the team',
        doAnimateImage: true),
    new PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/01.jpg',
        title: 'Screen 2',
        body: 'See the increase in productivity & output',
        doAnimateImage: true),
    new PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/01.jpg',
        title: 'Screen 3',
        body: 'Connect with the people from different places',
        doAnimateImage: true),
  ];
}
