import 'package:flutter/material.dart';

import '../../../features/auth/presentation/pages/register_view.dart';
import '../../../features/auth/presentation/pages/sign_in_view.dart';
import '../../../features/auth/presentation/pages/wrapper.dart';
import '../../../features/home/presentation/pages/home_view.dart';
import '../../../features/market_details/presentation/pages/market_details_view.dart';

class AppRoutes {
  // * Pages  App
  static Map<String, WidgetBuilder> routes = {
    SignInView.nameRoute: (context) => const SignInView(),
    RegisterView.nameRoute: (context) => const RegisterView(),
    HomeView.nameRoute: (context) => const HomeView(),
    MarketDetailsView.nameRoute: (context) => const MarketDetailsView(),
    Wrapper.nameRoute: (context) => const Wrapper(),
  };

  // * inti Route
  static String? get initRoute => Wrapper.nameRoute;

  // * push Name
  static void go(BuildContext context, String nameRoute) =>
      Navigator.pushNamed(context, nameRoute);
  // * push Name Replace
  static void goReplace(BuildContext context, String nameRoute) =>
      Navigator.pushReplacementNamed(context, nameRoute);

  // * push Name
  static void goMaterial(BuildContext context, Widget page) {
    MaterialPageRoute<Widget> route = MaterialPageRoute(
      builder: (context) => page,
    );
    Navigator.push(context, route);
  }
}

// * / -> index  -> home page
// * /setting
// * /about
