import 'package:cityswitch_app/features/home/domain/entities/maps_entites.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/style/app_text_style.dart';

class CustomNowPlayingCard extends StatelessWidget {
  const CustomNowPlayingCard({super.key, required this.results});

  final StorsEntites results;

  @override
  Widget build(BuildContext context) {
    return Image.network("${results.images}", fit: BoxFit.cover);
  }
}
