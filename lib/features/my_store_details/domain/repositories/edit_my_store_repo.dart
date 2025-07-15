import 'package:dartz/dartz.dart';
import '../../../../../../core/utils/constant/app_failure.dart';
import '../../data/models/edit_my_store_model/edit_my_store_model.dart';
import '../../data/models/my_store_model/my_store_model.dart';
import '../entities/edit_my_store_entite.dart';
import '../entities/my_data_store.dart';

abstract class EditMyStoreRepo {
  Future<Either<Failure, MyStoreEntite>> fechMyStore({required String id});

  Future<Either<Failure, EditMyStoreModel>> editMyStore({
    required EditMyStoreEntite editMyStoreEntite,
  });
}
