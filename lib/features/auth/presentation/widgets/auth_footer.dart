import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.first,
    required this.second,
    required this.onTap,
  });

  final String first, second;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: first,
        style: TextStyle(fontSize: 15, color: AppColors.black),
        children: <TextSpan>[
          const TextSpan(text: ' '),
          TextSpan(
            text: second,
            style: TextStyle(color: AppColors.blueMid, fontSize: 16),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
