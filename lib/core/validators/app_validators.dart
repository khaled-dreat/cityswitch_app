import 'package:validators/validators.dart' as validators;

import '../../features/auth/data/models/add_user_failure/m_error.dart';

class AppValidators {
  // ✳️ الرسائل الآن قابلة للتعديل
  static String messageEnterValue = "please Enter Value";
  static String messageCorrectEmail = "Invalid email address";
  static String messageCorrectPass =
      "You must enter a password consisting of 6 to 12 characters";
  static String messageConfirmPass = "Password Confirmation incorrect";

  // ✅ تحديث الرسائل من قائمة الأخطاء
  static void updateMessagesFromErrors(String rawErrorList) {
    final errors = ErrorModel.fromRawString(rawErrorList);

    for (var error in errors) {
      switch (error.path) {
        case 'email':
          messageCorrectEmail = error.msg!;
          break;
        case 'password':
          messageCorrectPass = error.msg!;
          break;
        case 'passwordConfirm':
          messageConfirmPass = error.msg!;
          break;
        case 'name':
          messageEnterValue = error.msg!;
          break;
      }
    }
  }

  static void resetMessages() {
    messageEnterValue = "please Enter Value";
    messageCorrectEmail = "Invalid email address";
    messageCorrectPass =
        "You must enter a password consisting of 6 to 12 characters";
    messageConfirmPass = "Password Confirmation incorrect";
  }

  // 🌟 Validators
  static String? isEmail(String? value) => templateValidator(
    value,
    !validators.isEmail(value ?? ''),
    messageCorrectEmail,
  );

  static String? isNotEmpty(String? value) => templateValidator(
    value,
    !validators.isLength(value ?? '', 3, 20),
    messageEnterValue,
  );

  static String? checkPass(String? value) => templateValidator(
    value,
    !validators.isLength(value ?? '', 6, 12),
    messageCorrectPass,
  );

  static String? checkConfirmPass(String? value, String? pass) =>
      templateValidator(
        value,
        !validators.equals(value?.trim(), pass),
        messageConfirmPass,
      );

  static String? templateValidator(
    String? value,
    bool condition,
    String errorMsg,
  ) {
    if (value?.isEmpty ?? true) {
      return messageEnterValue;
    } else if (condition) {
      return errorMsg;
    }
    return null;
  }
}
