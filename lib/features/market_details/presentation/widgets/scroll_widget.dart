import 'package:flutter/material.dart';
import '../../../../core/utils/style/app_colers.dart';

class ScrollWidget extends StatelessWidget {
  const ScrollWidget({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  final int length;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 8,
            width: currentIndex == index ? 20 : 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color:
                  currentIndex == index
                      ? AppColors.greenDark
                      : AppColors.greenDark.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
