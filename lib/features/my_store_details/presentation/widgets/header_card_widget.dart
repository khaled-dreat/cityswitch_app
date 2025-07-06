import 'package:flutter/material.dart';

import '../../../../../../core/utils/style/app_colers.dart';
import '../../../../../../core/utils/style/app_text_style.dart';

class HeaderCardWidget extends StatelessWidget {
  const HeaderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade600, Colors.blue.shade400],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.keyboard_arrow_left_sharp,
                color: AppColors.white,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.store_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Add your new store',
                style: AppTextStyle.h2Semibold24(
                  context,
                ).copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Fill in all the required information to add your store',
                style: AppTextStyle.h4Regular16(
                  context,
                ).copyWith(color: AppColors.greyC),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
