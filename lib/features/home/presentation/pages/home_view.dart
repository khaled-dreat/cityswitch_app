import 'package:cityswitch_app/features/home/presentation/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/widgets/app_bar/app_bar.dart';

class HomeView extends StatelessWidget {
  static const String nameRoute = "HomeView";

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomeViewBody());
  }
}
