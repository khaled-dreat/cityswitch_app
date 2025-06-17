import 'package:flutter/material.dart';

import '../../../../core/utils/style/app_colers.dart';

class CustomLoadingBtn extends StatelessWidget {
  const CustomLoadingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.greenBright,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}
