import 'package:cityswitch_app/app_start/app_start.dart';
import 'package:cityswitch_app/core/setup_service_locator/setup_service_locator.dart';
import 'package:cityswitch_app/features/auth/domain/entities/user_entites.dart';
import 'package:cityswitch_app/features/home/domain/entities/stors_entites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/simple_bloc_observer/simple_bloc_observer.dart';
import 'core/user_session/user_session_app.dart';
import 'core/utils/local_data/app_local_data_key.dart';
import 'features/auth/data/models/user_model/user_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserEntitesAdapter());
  Hive.registerAdapter(UserDataAdapter());
  setupServiceLocatorHome();
  setupServiceLocatorMyStore();
  setupServiceLocatorAuth();
  setupServiceLocatorChat();
  setupServiceLocatorAddStore();
  await openHiveBoxes();

  Bloc.observer = SimpleBlocObserver();
  await AppUserSession().init();

  runApp(const MyApp());
}

Future<void> openHiveBoxes() async {
  await Hive.openBox<UserEntites>(AppHiveKey.userBoxKey);
}
