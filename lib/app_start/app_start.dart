import 'package:cityswitch_app/core/setup_service_locator/setup_service_locator.dart';
import 'package:cityswitch_app/features/home/data/repositories/home_repo_emp.dart';
import 'package:cityswitch_app/features/home/domain/usecases/featured_maps_use_case.dart';
import 'package:cityswitch_app/features/home/domain/usecases/featured_store_categories_use_case.dart';
import 'package:cityswitch_app/features/home/presentation/manger/select_category_cubit/select_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../features/home/presentation/manger/fetch_home_cubit/home_cubit.dart';
import '../features/home/presentation/manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import '../features/home/presentation/pages/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MapSample()),
    );
  }
}

List<SingleChildWidget> get providers {
  return [
    BlocProvider(
      create: (context) {
        return HomeCubit(
          FeaturedMapsUseCase(mapsRepo: getIt.get<HomeRepoEmpl>()),
        );
      },
    ),
    BlocProvider(
      create: (context) {
        return StoresCategoriesCubit(
          FeaturedStoresCategoriesUseCase(homeRepo: getIt.get<HomeRepoEmpl>()),
        )..fetchStors();
      },
    ),
    BlocProvider(
      create: (context) {
        return StoreFilterCubit();
      },
    ),
  ];
}
