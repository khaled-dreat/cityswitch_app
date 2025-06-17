import 'package:flutter/material.dart';

import '../widgets/auth_app_icon.dart';
import '../widgets/auth_field_email.dart';
import '../widgets/auth_footer.dart';
import '../widgets/custom_btn.dart';

class PageForgotPass extends StatelessWidget {
  static const String nameRoute = 'PageForgotPass';
  static final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  const PageForgotPass({super.key});
  @override
  Widget build(BuildContext context) {
    // AuthCubit cAuth = Provider.of<AuthCubit>(context);

    return Scaffold(
      //  appBar: AuthAppBar(title: AppLangKey.forgotPass),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * Space
                  SizedBox(height: 20),
                  //    AppDime.lg.verticalSpace,
                  // * logo
                  AuthAppIcon(),
                  // * Space
                  SizedBox(height: 20),
                  // * hint Reset pass
                  Text(
                    "hintResetPass",
                    textAlign: TextAlign.center,
                    //  style: AppTheme.s1(context)?.copyWith(height: 1.5),
                  ),
                  // * Space
                  SizedBox(height: 20),
                  // * Email
                  const AuthFieldEmail(),
                  // * Space
                  SizedBox(height: 20),
                  // * Button Sign in
                  //   cAuth.loading
                  //       ? const AppLoading(loading: TypeLoading.send)
                  //       :
                  CustomBtn(
                    title: "send",
                    onTap: () {
                      if (keyForm.currentState?.validate() ?? false) {
                        // ✅

                        keyForm.currentState?.save();
                        //    cAuth.resetPass();
                        Navigator.pop(context);
                      }
                    },
                  ),
                  // * Space
                  SizedBox(height: 15),
                  // * Footer
                  AuthFooter(
                    first: "haveAccount",
                    second: "login",
                    onTap: () => Navigator.pop(context),
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
