import 'package:cityswitch_app/features/my_messages/data/models/get_all_my_meesages_model/get_all_my_meesages_model.dart';
import 'package:cityswitch_app/features/my_messages/domain/repositories/my_meesage_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/constant/app_failure.dart';

class GetAllMyMeesagesUseCase
    extends UseCase<List<GetAllMyMeesagesModel>, String> {
  final MyMeesageRepo myMeesageRepo;

  GetAllMyMeesagesUseCase({required this.myMeesageRepo});

  @override
  Future<Either<Failure, List<GetAllMyMeesagesModel>>> call([
    String? param,
  ]) async {
    return await myMeesageRepo.getAllMyMessages(userId: param!);
  }
}
