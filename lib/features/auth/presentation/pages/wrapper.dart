import 'dart:developer';
import 'package:cityswitch_app/core/utils/local_data/app_local_data_key.dart';
import 'package:cityswitch_app/features/auth/presentation/manger/wrapper_cubit/wrapper_cubit.dart';
import 'package:cityswitch_app/features/auth/presentation/manger/wrapper_cubit/wrapper_state.dart';
import 'package:cityswitch_app/features/auth/presentation/pages/sign_in_view.dart';
import 'package:cityswitch_app/features/my_messages/presentation/maneg/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../../home/presentation/manger/fetch_stores_categories_cubit/stores_categories_cubit.dart';
import '../../../my_store_details/presentation/manger/my_store_cubit/my_store_cubit.dart';
import '../manger/auth_cubit/auth_cubit.dart';

class Wrapper extends StatefulWidget {
  static const String nameRoute = 'Wrapper';
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final storesCategoriesCubit = BlocProvider.of<StoresCategoriesCubit>(
        context,
        listen: false,
      );
      final chatCubit = BlocProvider.of<ChatCubit>(context, listen: false);
      chatCubit.getMyContacts();
      storesCategoriesCubit.fetchStoresCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myStoreCubit = BlocProvider.of<MyStoreCubit>(context, listen: false);

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
