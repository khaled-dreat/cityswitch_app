import 'package:flutter/material.dart';

import '../../../../test.dart';
import 'map_widget.dart';
import 'market_list.dart';
import 'search_with_categories_widget.dart';
import 'search_with_dropdown.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SearchWithCategoriesWidget(), MapWidget(), MarketList()],
    );
  }
}
