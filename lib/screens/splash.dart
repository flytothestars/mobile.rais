import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'onboarding.dart';
import 'package:mobileapp_diplom2022_1_0_0/models/api_response.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/home.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/login.dart';
import 'package:mobileapp_diplom2022_1_0_0/services/constant.dart';
import 'package:mobileapp_diplom2022_1_0_0/services/user_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _loadUserInfo() async {
    String token = await getToken();
    bool firstRun = await IsFirstRun.isFirstRun();
    if (firstRun) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OnboardingScreen()));
    } else if (token == '' || token == null) {
      Navigator.of(this.context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        Navigator.of(this.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      } else if (response.error == unauthorized) {
        Navigator.of(this.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      } else {
        // ScaffoldMessenger.of(this.context)
        //     .showSnackBar(SnackBar(content: Text('$response.error')));
        Navigator.of(this.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      _loadUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://st.depositphotos.com/1537427/3571/v/600/depositphotos_35716531-stock-illustration-vector-lightning-icon.jpg")),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            height: 64,
          ),
          Text(
            "RaiS",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Spacer()
        ],
      ),
    ));
  }
}
