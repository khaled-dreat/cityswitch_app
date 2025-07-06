import 'package:cityswitch_app/features/add_store/data/models/add_store/m_add_store.dart';
import 'package:cityswitch_app/features/add_store/domain/entities/add_store.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/utils/constant/app_failure.dart';
import '../../../home/domain/entities/stors_entites.dart';
import '../../data/models/search_addresses/search_addresses.dart';

abstract class EditMyStoreRepo {
  Future<Either<Failure, StorsEntites>> fechMyStore({required String id});

  Future<Either<Failure, AddStoreModel>> editMyStore({
    required AddStoreEntite addStoreModel,
  });
}
