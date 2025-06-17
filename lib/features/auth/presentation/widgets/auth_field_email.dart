import 'package:cityswitch_app/features/auth/presentation/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/validators/app_validators.dart';
import '../manger/auth_cubit/auth_cubit.dart';

class AuthFieldEmail extends StatelessWidget {
  const AuthFieldEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthCubit cAuth = BlocProvider.of<AuthCubit>(context);
    return CustomTextForm(
      label: "Email",
      preIcon: Icons.email,
      validator: AppValidators.isEmail,
      keyboardType: TextInputType.emailAddress,
      onSaved: cAuth.authModel.setEmail,
    );
  }
}
