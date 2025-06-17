import 'package:cityswitch_app/features/auth/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/validators/app_validators.dart';
import '../manger/auth_cubit/auth_cubit.dart';

class AuthFieldPass extends StatelessWidget {
  const AuthFieldPass({Key? key, this.isConfirm = false}) : super(key: key);
  final bool isConfirm;
  @override
  Widget build(BuildContext context) {
    AuthCubit cAuth = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        bool isNotShowPass = cAuth.isNotShowPass; // القيمة الافتراضية
        if (state is AuthisNotShowPass) {
          isNotShowPass = state.isNotShowPass;
        }
        return CustomTextForm(
          label: isConfirm ? "Password Confirm" : "Password",
          preIcon: Icons.vpn_key,
          postIcon: context.read<AuthCubit>().icon,
          isPass: isNotShowPass,
          onTogglePass: cAuth.changeIcon, // 👈 دالة التبديل
          validator: (value) {
            return isConfirm
                ? AppValidators.checkConfirmPass(value, cAuth.currentPass)
                : AppValidators.checkPass(value);
          },
          onChanged: !isConfirm ? cAuth.setCurrentPass : null,
          onSaved: (value) {
            cAuth.authModel.setPass(value);
            cAuth.authModel.setpasswordConfirm(value);
          },
        );
      },
    );
  }
}
