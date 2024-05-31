import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/user_model.dart';
import 'package:at_your_home_partner/screens/home_screen.dart';
import 'package:at_your_home_partner/screens/login_screen.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigator();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Image.asset(
        splash,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.fill,
      )),
    ));
  }

  _navigator() async {
    var instance = await SharedPreferences.getInstance();
    var crtData = instance.getString('currentUser');
    await Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        if (crtData != null) {
          UserModel crtUser = UserModel.fromJson(jsonDecode(crtData));
          Log.console(crtUser.data!.mobile.toString());
          Get.offAll(() => const HomeScreen());
        } else {
          Get.off(() => const LoginScreen());
        }
      },
    );
  }
}
