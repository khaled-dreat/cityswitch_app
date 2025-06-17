import 'package:cityswitch_app/features/auth/presentation/manger/wrapper_cubit/wrapper_cubit.dart';
import 'package:cityswitch_app/features/auth/presentation/pages/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/routes/app_routes.dart';
import '../../../../core/utils/widgets/toast/app_toast.dart';
import '../manger/auth_cubit/auth_cubit.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_app_icon.dart';
import '../widgets/auth_field_email.dart';
import '../widgets/auth_field_pass.dart';
import '../widgets/auth_footer.dart';
import '../widgets/auth_forgot_pass.dart';
import '../widgets/custom_btn.dart';
import '../widgets/custom_loading_btn.dart';

class SignInView extends StatelessWidget {
  static const String nameRoute = 'PageSignIn';
  static final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    AuthCubit cAuth = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AuthAppBar(title: "login"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: keyForm,
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
                  const AuthFieldEmail(),
                  // * Space
                  SizedBox(height: 20),
                  // * Pass
                  const AuthFieldPass(),
                  // * Forgot Pass
                  const AuthForgotPass(),
                  SizedBox(height: 40),

                  // * Button Sign in
                  // cAuth.loading
                  //     ? const AppLoading(loading: TypeLoading.send)
                  //     :
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is RegisterationSuccess) {
                        context.read<WrapperCubit>().checkUserStatus();
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
                        title: "Login",

                        onTap: () async {
                          if (keyForm.currentState?.validate() ?? false) {
                            // ✅

                            keyForm.currentState?.save();
                            await cAuth.loginUser();
                            //  if ( != null) {
                            //  } else {
                            //    AppToast.toast(cAuth.errorMessage);
                            //  }
                          }
                        },
                      );
                    },
                  ),

                  // * Space
                  SizedBox(height: 20),
                  // * Footer
                  AuthFooter(
                    first: "Do not have Account",
                    second: "Register",
                    onTap: () => AppRoutes.go(context, RegisterView.nameRoute),
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
