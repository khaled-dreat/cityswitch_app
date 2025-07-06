import 'package:cityswitch_app/features/add_store/data/models/add_store/m_add_store.dart';
import 'package:cityswitch_app/features/add_store/domain/entities/add_store.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/constant/app_failure.dart';
import '../../data/models/search_addresses/search_addresses.dart';

abstract class AddStoreRepo {
  Future<Either<Failure, AddStoreModel>> addStore({
    required AddStoreEntite addStoreModel,
  });

  Future<Either<Failure, List<SearchAddressesModel>>> getSearchAddresses({
    required String endPoint,
  });
}
