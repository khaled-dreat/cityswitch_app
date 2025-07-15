import 'package:cityswitch_app/core/setup_service_locator/setup_service_locator.dart';
import 'package:cityswitch_app/core/utils/routes/app_routes.dart';
import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:cityswitch_app/features/add_store/data/repositories/add_store_repo_emp.dart';
import 'package:cityswitch_app/features/add_store/domain/usecases/add_store%20_use_case.dart';
import 'package:cityswitch_app/features/add_store/domain/usecases/fetch_search_addresses_use_case.dart';
import 'package:cityswitch_app/features/auth/data/repositories/auth_repo_emp.dart';
import 'package:cityswitch_app/features/auth/domain/usecases/login_user_use_case.dart';
import 'package:cityswitch_app/features/auth/domain/usecases/registeration_user_use_case.dart';
import 'package:cityswitch_app/features/home/data/repositories/home_repo_emp.dart';
import 'package:cityswitch_app/features/home/domain/entities/stors_entites.dart';
import 'package:cityswitch_app/features/home/domain/usecases/search_store_use_case.dart';
import 'package:cityswitch_app/features/my_store_details/domain/usecases/edit_my_store%20_use_case.dart';
import 'package:cityswitch_app/features/my_store_details/domain/usecases/stores_by_user_Id_use_case.dart';
import 'package:cityswitch_app/features/home/domain/usecases/featured_store_categories_use_case.dart';
import 'package:cityswitch_app/features/my_store_details/presentation/manger/my_store_cubit/my_store_cubit.dart';
import 'package:cityswitch_app/features/home/presentation/manger/select_category_cubit/select_category_cubit.dart';
import 'package:cityswitch_app/features/market_details/presentation/manger/cubit/market_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../features/add_store/presentation/manger/add_store/add_store_cubit.dart';
import '../features/add_store/presentation/manger/keywords_cubit/keywords_cubit.dart';
import '../features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import '../features/home/presentation/manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import '../features/home/presentation/manger/map_cubit/map_cubit.dart';
import '../features/home/presentation/manger/store_cubit/stors_cubit.dart';
import '../features/my_store_details/data/repositories/edit_my_store_repo_emp.dart';
import '../features/my_store_details/presentation/manger/edit_my_store_cubit/edit_my_store_cubit.dart';
import '../features/my_store_details/presentation/manger/edit_select_category_cubit/edit_select_category_cubit.dart';
import '../features/my_store_details/presentation/manger/edit_keywords_cubit/edit_keywords_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: AppColors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.initRoute,
      ),
    );
  }
}

List<SingleChildWidget> get providers {
  return [
    BlocProvider(
      create: (context) {
        return StorsCubit(
          SearchStoresUseCase(homeRepo: getIt.get<HomeRepoEmpl>()),
        );
      },
    ),
    BlocProvider(
      create: (context) {
        return AuthCubit(
          RegisterationUserUseCase(authRepo: getIt.get<AuthRepoEmpl>()),
          LoginUserUseCase(authRepo: getIt.get<AuthRepoEmpl>()),
        );
      },
    ),
    BlocProvider(
      create: (context) {
        return StoresCategoriesCubit(
          StoresCategoriesUseCase(homeRepo: getIt.get<HomeRepoEmpl>()),
        );
      },
    ),

    BlocProvider(
      create: (context) {
        return SelectCategoryDropDownCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return EditSelectCategoryDropDownCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return AddStoreCubit(
          AddStoreUseCase(addStoreRepo: getIt.get<AddStoreRepoEmpl>()),
          FetchSearchAddressesUseCase(
            addStoreRepo: getIt.get<AddStoreRepoEmpl>(),
          ),
        );
      },
    ),
    BlocProvider(
      create: (context) {
        return KeywordsCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return SelectedCategoryCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return SelectSubCategoryDropDownCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return EditKeywordsCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return EditSelectedCategoryCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return EditSelectSubCategoryDropDownCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return MapCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return EditMyStoreCubit(
          EditMyStoreUseCase(editMyStoreRepo: getIt.get<EditMyStoreRepoEmpl>()),
        );
      },
    ),
    BlocProvider(
      create: (context) {
        return MarketDetailsCubit(StorsEntites());
      },
    ),
    BlocProvider(
      create: (context) {
        return MyStoreCubit(
          StoresByUserIdUseCase(
            editMyStoreRepo: getIt.get<EditMyStoreRepoEmpl>(),
          ),
        );
      },
    ),
  ];
}
