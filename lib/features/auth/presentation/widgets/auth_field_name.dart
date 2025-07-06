import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/validators/app_validators.dart';
import '../manger/auth_cubit/auth_cubit.dart';
import 'text_form_field.dart';

class AuthFieldName extends StatelessWidget {
  const AuthFieldName({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cAuth = BlocProvider.of<AuthCubit>(context);
    return CustomTextForm(
      label: "Your Name",
      preIcon: Icons.person_rounded,
      validator: AppValidators.isNotEmpty,
      keyboardType: TextInputType.name,
      onSaved: cAuth.authModel.setName,
    );
  }
}
