import 'package:flutter/material.dart';

class CustomTextFieldAddStore extends StatelessWidget {
  const CustomTextFieldAddStore({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
    this.onSaved,
  });
  final String hintText;
  final IconData? prefixIcon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        validator: validator,
        onSaved: onSaved,

        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(fontFamily: 'Arial Unicode MS'),
        decoration: InputDecoration(
          hintText: hintText,
          alignLabelWithHint: true,
          helperMaxLines: 2,

          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontFamily: 'Arial Unicode MS',
          ),

          prefixIcon:
              prefixIcon == null
                  ? null
                  : Icon(prefixIcon, color: Colors.grey.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
