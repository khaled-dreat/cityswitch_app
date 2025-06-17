import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    this.height,
    required this.title,
    required this.onTap,
  });

  final double? height;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.greenDark70,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: height ?? 50,
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.greenBright,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(color: AppColors.white, fontSize: 20),
        ),
      ),
    );
  }
}
