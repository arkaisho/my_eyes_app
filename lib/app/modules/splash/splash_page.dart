import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';
import 'package:my_eyes/app/utils/authentication.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() async {
    await Future.delayed(Duration(seconds: 2));
    await Authentication.authenticated().then(
      (authenticated) {
        if (authenticated) {
          Modular.to.pushReplacementNamed("/products");
        } else {
          Modular.to.pushReplacementNamed("/home");
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Loading",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(height: 15),
              Container(
                width: 30,
                child: LinearProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.mainBlue,
              Colors.white,
            ],
          ),
        ),
      ),
    );
  }
}
