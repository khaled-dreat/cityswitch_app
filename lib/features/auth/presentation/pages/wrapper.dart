import 'dart:developer';
import 'package:cityswitch_app/core/utils/local_data/app_local_data_key.dart';
import 'package:cityswitch_app/features/auth/presentation/manger/wrapper_cubit/wrapper_cubit.dart';
import 'package:cityswitch_app/features/auth/presentation/manger/wrapper_cubit/wrapper_state.dart';
import 'package:cityswitch_app/features/auth/presentation/pages/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../../home/presentation/manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import '../../../my_store_details/presentation/manger/my_store_cubit/my_store_cubit.dart';
import '../manger/auth_cubit/auth_cubit.dart';

class Wrapper extends StatelessWidget {
  static const String nameRoute = 'Wrapper';
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final myStoreCubit = BlocProvider.of<MyStoreCubit>(context, listen: false);
    final storesCategoriesCubit = BlocProvider.of<StoresCategoriesCubit>(
      context,
      listen: false,
    );
    storesCategoriesCubit.fetchStoresCategories();
    return Scaffold(
      body: FutureBuilder(
        future: myStoreCubit.fetchMyStoresByUserIdOnce(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final userHasStore = false; // true / false

          return CustomBottomNavigationBar(userHasStore: userHasStore);
        },
      ),
    );
  }
}
