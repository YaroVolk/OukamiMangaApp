import 'package:Oukami/config/Config.dart';
import 'package:flutter/material.dart';
import 'package:Oukami/database/LocalDataSystem.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  void navigateToHome() {
    Future.delayed(Duration(seconds: 3), () {
      LocalDataSystem().initData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                "lib/assets/icon/SplashIcon.png",
                width: 500,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(BGColor),
            )
          ],
        ),
      ),
    );
  }
}
