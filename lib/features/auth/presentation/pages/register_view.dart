import 'package:cityswitch_app/core/utils/style/app_colers.dart';
import 'package:cityswitch_app/features/auth/presentation/pages/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/routes/app_routes.dart';
import '../../../../core/utils/widgets/toast/app_toast.dart';
import '../manger/auth_cubit/auth_cubit.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_app_icon.dart';
import '../widgets/auth_field_email.dart';
import '../widgets/auth_field_name.dart';
import '../widgets/auth_field_pass.dart';
import '../widgets/auth_footer.dart';
import '../widgets/custom_btn.dart';
import '../widgets/custom_loading_btn.dart';

class RegisterView extends StatefulWidget {
  static const String nameRoute = 'PageRegister';
  static final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    AuthCubit cAuth = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AuthAppBar(title: "Register"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: RegisterView.keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * Space
                  SizedBox(height: 20),
                  // * logo
                  const AuthAppIcon(),
                  // * Space
                  SizedBox(height: 20),
                  // * Email
                  const AuthFieldName(),
                  SizedBox(height: 20),
                  // * Email
                  const AuthFieldEmail(),
                  // * Space
                  SizedBox(height: 20),
                  // * Pass
                  const AuthFieldPass(),
                  // * Space
                  SizedBox(height: 20),

                  // * Confirm Pass
                  const AuthFieldPass(isConfirm: true),
                  // * Space
                  SizedBox(height: 20),

                  // * Forgot Pass
                  // * idea from Abdallah
                  // Visibility(
                  //   visible: false,
                  //   child: AuthForgotPass(),
                  //   maintainSize: true,
                  //   maintainAnimation: true,
                  //   maintainState: true,
                  // ),

                  // * Button Sign in
                  //  cAuth.loading
                  //      ? const AppLoading(loading: TypeLoading.send)
                  //      :
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is RegisterationSuccess) {
                        AppToast.toast(
                          "User registration successful",
                          color: AppColors.greenBright60,
                        );
                        //       AppRoutes.goReplace(context, SignInView.nameRoute);
                      } else if (state is AddUserFailure) {
                        // عرض رسالة الخطأ
                        AppToast.toast(state.errMessage);
                      } else {}
                    },
                    builder: (context, state) {
                      if (state is RegisterationLoading) {
                        return CustomLoadingBtn();
                      }
                      return CustomBtn(
                        title: "Registeration",
                        onTap: () async {
                          if (RegisterView.keyForm.currentState?.validate() ??
                              false) {
                            RegisterView.keyForm.currentState?.save();
                            cAuth.registerationUser();
                          }
                        },
                      );
                    },
                  ),

                  // * Space
                  SizedBox(height: 20),
                  // * Footer
                  AuthFooter(
                    first: "haveAccount",
                    second: "login",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
