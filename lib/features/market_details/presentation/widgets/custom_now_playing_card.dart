import 'package:flutter/material.dart';

import '../../../../core/utils/style/app_text_style.dart';
import '../../../home/domain/entities/stors_entites.dart';

class CustomNowPlayingCard extends StatelessWidget {
  const CustomNowPlayingCard({super.key, required this.results});

  final StorsEntites results;

  @override
  Widget build(BuildContext context) {
    return Image.network("${results.images}", fit: BoxFit.cover);
  }
}
