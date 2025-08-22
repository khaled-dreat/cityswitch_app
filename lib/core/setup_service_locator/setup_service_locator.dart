import 'package:cityswitch_app/features/add_store/data/datasources/add_store_remote_data_source.dart';
import 'package:cityswitch_app/features/add_store/data/repositories/add_store_repo_emp.dart';
import 'package:cityswitch_app/features/auth/data/datasources/auth_user_remote_data_source.dart';
import 'package:cityswitch_app/features/auth/data/repositories/auth_repo_emp.dart';
import 'package:cityswitch_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:cityswitch_app/features/home/data/repositories/home_repo_emp.dart';
import 'package:cityswitch_app/features/my_messages/data/datasources/my_meesage_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/my_messages/data/repositories/message_repository_impl.dart';
import '../../features/my_store_details/data/datasources/edit_my_store_remote_data_source.dart';
import '../../features/my_store_details/data/repositories/edit_my_store_repo_emp.dart';
import '../api/api_service.dart';
import '../services/socket_service/socket_service.dart';

final getIt = GetIt.instance;

void setupServiceLocatorHome() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<HomeRepoEmpl>(
    HomeRepoEmpl(
      homeRemoteDataSource: StoresDataSourceImp(
        apiService: getIt.get<ApiService>(),
      ),
    ),
  );
}

void setupServiceLocatorMyStore() {
  getIt.registerSingleton<EditMyStoreRepoEmpl>(
    EditMyStoreRepoEmpl(
      editMyStoreRemoteDataSource: EditMyStoreRemoteDataSourceImp(
        apiService: getIt.get<ApiService>(),
      ),
    ),
  );
}

void setupServiceLocatorAuth() {
  getIt.registerSingleton<AuthRepoEmpl>(
    AuthRepoEmpl(
      authRemoteDataSource: AuthDataSourceImp(
        apiService: getIt.get<ApiService>(),
      ),
    ),
  );
}

void setupServiceLocatorChat() {
  // تسجيل ApiService أولًا (تأكد أنه موجود)
  final apiService = getIt.get<ApiService>();

  // ➊ تسجيل SocketService كمزود Singleton
  getIt.registerSingleton<SocketService>(
    SocketService(), // سيتم إعادة تهيئته لاحقًا
  );

  // ➋ تسجيل MessagesRemoteDataSource
  final remoteDataSource = MessagesRemoteDataSourceImpl(apiService: apiService);

  // ➌ تسجيل MessageRepositoryImpl
  getIt.registerSingleton<MessageRepositoryImpl>(
    MessageRepositoryImpl(
      remoteDataSource: remoteDataSource,
      socketService: getIt.get<SocketService>(),
    ),
  );
}

void setupServiceLocatorAddStore() {
  getIt.registerSingleton<AddStoreRepoEmpl>(
    AddStoreRepoEmpl(
      addStoreDataSourceImp: AddStoreDataSourceImp(
        apiService: getIt.get<ApiService>(),
      ),
    ),
  );
}
