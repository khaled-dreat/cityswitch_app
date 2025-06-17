import 'package:flutter/material.dart';

import '../../../../core/utils/style/app_colers.dart';

class AuthForgotPass extends StatelessWidget {
  const AuthForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: () {
          //  AppRoutes.go(context, PageForgotPass.nameRoute);
        },
        child: Text(
          "Forgot Password",
          style: TextStyle(color: AppColors.black),
        ),
      ),
    );
  }
}
