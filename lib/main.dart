import 'package:cityswitch_app/app_start/app_start.dart';
import 'package:cityswitch_app/core/setup_service_locator/setup_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/simple_bloc_observer/simple_bloc_observer.dart';

void main() {
  setupServiceLocatorHome();

  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}
