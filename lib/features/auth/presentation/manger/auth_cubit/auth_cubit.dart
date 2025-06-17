import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cityswitch_app/core/utils/local_data/app_local_data_key.dart';
import 'package:cityswitch_app/features/auth/domain/entities/user_entites.dart';
import 'package:cityswitch_app/features/auth/domain/usecases/login_user_use_case.dart';
import 'package:cityswitch_app/features/auth/domain/usecases/registeration_user_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/utils/constant/app_icons.dart';
import '../../../../../core/validators/app_validators.dart';
import '../../../data/models/auth/auth_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.registerationUserUseCase, this.loginUserUseCase)
    : super(AuthInitial());
  final RegisterationUserUseCase registerationUserUseCase;
  final LoginUserUseCase loginUserUseCase;

  // ******************** Eye ********************
  IconData icon = AppIcons.showPass;
  bool isNotShowPass = true;

  void changeIcon() {
    isNotShowPass = !isNotShowPass;
    icon = isNotShowPass ? AppIcons.showPass : AppIcons.noShowPass;
    print('isNotShowPass: $isNotShowPass');
    emit(AuthisNotShowPass(isNotShowPass: isNotShowPass));
  }

  // *************** Auth User ***********
  AuthModel authModel = AuthModel();

  String currentPass = '';

  void setCurrentPass(String value) {
    currentPass = value;
  }

  // * Firebase Auth

  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool loading = false;
  String errorMessage = '';

  set changeLoading(bool value) {
    loading = value;
  }

  set updateMessage(String value) {
    errorMessage = value;
  }

  // * Register
  Future<void> registerationUser() async {
    emit(RegisterationLoading());
    var result = await registerationUserUseCase.call(authModel);
    result.fold(
      (failure) {
        log(name: "failure", failure.message);
        AppValidators.updateMessagesFromErrors(failure.message);

        emit(AddUserFailure(errMessage: failure.message));
      },
      (user) {
        emit(RegisterationSuccess(user: user));
      },
    );
  }

  // * Login
  Future<void> loginUser() async {
    emit(RegisterationLoading());
    var result = await loginUserUseCase.call(authModel);
    result.fold(
      (failure) {
        //   log(name: "failure", failure.message);
        emit(AddUserFailure(errMessage: failure.message));
      },
      (user) {
        //     log(user.data.name!.toString());
        emit(RegisterationSuccess(user: user));
        saveUserData(user, AppHiveKey.userBoxKey);
      },
    );
  }

  void saveUserData(UserEntites userEntites, String boxName) async {
    var box = Hive.box<UserEntites>(boxName);
    await box.put(AppHiveKey.userBoxKey, userEntites);
  }

  //// * Forgot pass
  //Future<void> resetPass() async {
  //  try {
  //    changeLoading = true;
  //    await firebaseAuth.sendPasswordResetEmail(email: userAuth.email!);
  //    changeLoading = false;
  //  } on SocketException {
  //    changeLoading = false;
  //    updateMessage = AppLangKey.noInternet.tr();
  //  } on FirebaseAuthException catch (error) {
  //    changeLoading = false;
  //    updateMessage = error.message ?? '';
  //  } catch (e) {
  //    changeLoading = false;
  //    updateMessage = e.toString();
  //  }
}

// * signOut
Future<void> signOut() async {
  //   firebaseAuth.signOut();
}

// * user state
//  Stream<User?> get currentUser => firebaseAuth.authStateChanges();
