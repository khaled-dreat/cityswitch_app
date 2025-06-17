import 'package:flutter/material.dart';

class AuthAppIcon extends StatelessWidget {
  const AuthAppIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage("assets/img/logo/logo.png"),
      width: MediaQuery.sizeOf(context).width * 0.40,
    );
  }
}
