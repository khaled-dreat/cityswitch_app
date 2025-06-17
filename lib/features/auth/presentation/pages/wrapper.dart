import 'dart:developer';

import 'package:cityswitch_app/core/utils/local_data/app_local_data_key.dart';
import 'package:cityswitch_app/core/utils/routes/app_routes.dart';
import 'package:cityswitch_app/features/auth/presentation/manger/wrapper_cubit/wrapper_cubit.dart';
import 'package:cityswitch_app/features/auth/presentation/manger/wrapper_cubit/wrapper_state.dart';
import 'package:cityswitch_app/features/auth/presentation/pages/sign_in_view.dart';
import 'package:cityswitch_app/features/home/presentation/pages/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manger/auth_cubit/auth_cubit.dart';

class Wrapper extends StatelessWidget {
  static const String nameRoute = 'Wrapper';
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cAuth = BlocProvider.of<AuthCubit>(context, listen: false);
    return Scaffold(
      body: BlocProvider(
        create:
            (_) =>
                WrapperCubit(boxName: AppHiveKey.userBoxKey)..checkUserStatus(),
        child: BlocBuilder<WrapperCubit, WrapperState>(
          builder: (context, state) {
            if (state is UserExists) {
              return HomeView();
            } else if (state is UserDoesNotExist) {
              log("❌ لا يوجد مستخدم محفوظ");
              return SignInView();
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
