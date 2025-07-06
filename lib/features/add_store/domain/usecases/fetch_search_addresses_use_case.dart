import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';
import '../../data/models/search_addresses/search_addresses.dart';
import '../repositories/add_store_repo.dart';

class FetchSearchAddressesUseCase
    extends UseCase<List<SearchAddressesModel>, String> {
  final AddStoreRepo addStoreRepo;

  FetchSearchAddressesUseCase({required this.addStoreRepo});

  @override
  Future<Either<Failure, List<SearchAddressesModel>>> call([
    String? param,
  ]) async {
    return await addStoreRepo.getSearchAddresses(endPoint: param!);
  }
}
