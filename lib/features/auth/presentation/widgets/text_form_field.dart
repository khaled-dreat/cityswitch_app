import 'package:flutter/material.dart';

import '../../../../core/utils/style/app_colers.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm({
    super.key,
    this.initValue,
    this.keyboardType,
    this.isPass = false,
    this.validator,
    this.onSaved,
    this.onChanged,
    // * Decoration
    this.hint,
    this.label,
    this.help,
    this.preIcon,
    this.postIcon,
    this.onTogglePass, // 👈 أضف هذا
  });
  final String? initValue;
  final TextInputType? keyboardType;
  final bool isPass;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  // * Decoration
  final String? hint;
  final String? label;
  final String? help;
  final IconData? preIcon;
  final IconData? postIcon;
  final VoidCallback? onTogglePass; // 👈 أضف هذا

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      initialValue: widget.initValue,
      keyboardType: widget.keyboardType,
      cursorColor: Colors.green,
      obscureText: widget.isPass,
      obscuringCharacter: '●',
      textCapitalization: TextCapitalization.none,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w700,
        ),
        border: InputBorder.none,
        helperText: widget.help,
        helperMaxLines: 2,
        prefixIcon:
            widget.preIcon != null
                ? Icon(widget.preIcon, color: Colors.grey)
                : null,
        suffixIcon:
            widget.postIcon != null
                ? IconButton(
                  onPressed:
                      widget
                          .onTogglePass, // 👈 استخدام الدالة القادمة من خارج الودجت
                  icon: Icon(widget.postIcon, color: AppColors.greenBright),
                )
                : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.greenBright, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.greenBright, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.greenBright, width: 2),
        ),
      ),
    );
  }
}
