import 'package:cityswitch_app/features/home/domain/entities/stores_category_entites.dart';
import 'package:cityswitch_app/features/home/domain/entities/stors_entites.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/constant/app_failure.dart';
import '../../data/models/search_store/m_search_parmeter.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<StorsCategoryEntites>>> fechCategore();
  Future<Either<Failure, List<StorsEntites>>> fechSearchstores({
    SearchParmeterModel searchParmeterModel,
  });
}
