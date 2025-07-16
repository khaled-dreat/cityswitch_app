import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/domain/entities/user_entites.dart';
import '../utils/local_data/app_local_data_key.dart';

class AppUserSession {
  static final AppUserSession _instance = AppUserSession._internal();

  factory AppUserSession() => _instance;

  AppUserSession._internal();

  String? _userId;

  Future<void> init() async {
    final box = Hive.box<UserEntites>(AppHiveKey.userBoxKey);
    _userId = box.isNotEmpty ? box.values.first.data?.id : null;
  }

  String? get userId => _userId;
}
