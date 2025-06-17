import 'package:cityswitch_app/core/setup_service_locator/setup_service_locator.dart';
import 'package:cityswitch_app/core/utils/routes/app_routes.dart';
import 'package:cityswitch_app/features/auth/data/repositories/auth_repo_emp.dart';
import 'package:cityswitch_app/features/auth/domain/usecases/login_user_use_case.dart';
import 'package:cityswitch_app/features/auth/domain/usecases/registeration_user_use_case.dart';
import 'package:cityswitch_app/features/home/data/repositories/home_repo_emp.dart';
import 'package:cityswitch_app/features/home/domain/entities/maps_entites.dart';
import 'package:cityswitch_app/features/home/domain/usecases/stores_by_categore_Id_use_case.dart';
import 'package:cityswitch_app/features/home/domain/usecases/featured_store_categories_use_case.dart';
import 'package:cityswitch_app/features/home/presentation/manger/select_category_cubit/select_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import '../features/home/presentation/manger/store_cubit/stors_cubit.dart';
import '../features/home/presentation/manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import '../features/market_details/presentation/manger/cubit/market_details_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
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
          StoresByCategoreIdUseCase(mapsRepo: getIt.get<HomeRepoEmpl>()),
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
        )..fetchStoresCategories();
      },
    ),
    BlocProvider(
      create: (context) {
        return StoreFilterCubit();
      },
    ),
    BlocProvider(
      create: (context) {
        return MarketDetailsCubit(StorsEntites());
      },
    ),
  ];
}
