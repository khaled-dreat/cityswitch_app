import 'package:cityswitch_app/features/home/data/datasources/maps_remote_data_source.dart';
import 'package:cityswitch_app/features/home/data/repositories/home_repo_emp.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../api/api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocatorHome() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<HomeRepoEmpl>(
    HomeRepoEmpl(
      homeRemoteDataSource: MapsDataSourceImp(
        apiService: getIt.get<ApiService>(),
      ),
    ),
  );
}
