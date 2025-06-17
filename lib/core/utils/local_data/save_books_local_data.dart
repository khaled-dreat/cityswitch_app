import 'package:cityswitch_app/features/auth/domain/entities/user_entites.dart';
import 'package:hive/hive.dart';

void saveBooksData(UserEntites userEntites, String boxName) {
  var box = Hive.box<UserEntites>(boxName);
  box.add(userEntites);
}
