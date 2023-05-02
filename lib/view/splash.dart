import 'package:flutter/material.dart';

import 'package:food_livraison_app/theme/theme_colors.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Image.asset("asset/icon/logo.png"),
        )),
      ),
    );
  }
}
