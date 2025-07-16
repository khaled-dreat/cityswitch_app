import 'package:flutter/material.dart';

import '../../../features/add_store/presentation/pages/add_store_view.dart';
import '../../../features/auth/presentation/pages/register_view.dart';
import '../../../features/auth/presentation/pages/sign_in_view.dart';
import '../../../features/auth/presentation/pages/wrapper.dart';
import '../../../features/choose_plan /presentation/pages/pricing_plans_screen.dart';
import '../../../features/home/presentation/pages/home_view.dart';
import '../../../features/market_details/presentation/pages/market_details_view.dart';
import '../../../features/my_messages/presentation/pages/my_messages.dart';
import '../../../test.dart';

class AppRoutes {
  // * Pages  App
  static Map<String, WidgetBuilder> routes = {
    SignInView.nameRoute: (context) => const SignInView(),
    RegisterView.nameRoute: (context) => const RegisterView(),
    HomeView.nameRoute: (context) => const HomeView(),
    MarketDetailsScreen.nameRoute: (context) => const MarketDetailsScreen(),
    Wrapper.nameRoute: (context) => const Wrapper(),
    ChoosePlan.nameRoute: (context) => const ChoosePlan(),
    AddStoreView.nameRoute: (context) => const AddStoreView(),
    ChatView.nameRoute: (context) => const ChatView(),
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
