import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/login.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/logreg.dart';

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
              .push(MaterialPageRoute(builder: ((context) => LogReg())));
        },
        finishCallback: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => LogReg())));
        },
      ),
    );
  }

  final pages = [
    new PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'assets/01.jpg',
        title: 'Скачай',
        body: 'Скачай наш приложение',
        doAnimateImage: true),
    new PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/01.jpg',
        title: 'Открой',
        body: 'Быстрая регистрация',
        doAnimateImage: true),
    new PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/01.jpg',
        title: 'Арендуй',
        body: 'Арендуй PowerBank',
        doAnimateImage: true),
  ];
}
