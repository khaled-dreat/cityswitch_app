import 'package:cityswitch_app/features/home/data/models/search_store/m_search_parmeter.dart';
import 'package:cityswitch_app/features/home/domain/entities/stors_entites.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../repositories/maps_repo.dart';

class SearchStoresUseCase
    extends UseCase<List<StorsEntites>, SearchParmeterModel> {
  final HomeRepo homeRepo;

  SearchStoresUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<StorsEntites>>> call([
    SearchParmeterModel? param,
  ]) async {
    return await homeRepo.fechSearchstores(searchParmeterModel: param!);
  }
}
