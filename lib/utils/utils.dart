import 'dart:io';
import 'dart:ui';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/generated/l10n.dart';

class Utils {
  ///Search
  // static bool isTextContainKeyword({String text = "", String keyword = ""}) {
  //   final newText = String.fromCharCodes(replaceCodeUnits(text.codeUnits)).toLowerCase();
  //   final newKeyword = String.fromCharCodes(replaceCodeUnits(keyword.codeUnits)).toLowerCase();
  //   final isContain = newText.contains(newKeyword);
  //   return isContain;
  // }
  //
  // static launchPhoneCall({String phone}) async {
  //   try {
  //     await launch("tel:$phone");
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }
  //
  // static launchEmail({String email}) async {
  //   try {
  //     await launch(Uri(
  //       scheme: 'mailto',
  //       path: email,
  //     ).toString());
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }

  /// Checks if string is email.
  static bool isEmail(String email) => GetUtils.isEmail(email);

  /// Checks if string is phone number.
  static bool isPhoneNumber(String email) => GetUtils.isPhoneNumber(email);

  /// Checks if string is URL.
  static bool isURL(String url) => GetUtils.isURL(url);

  /// Check is string is password
  static bool isPassword(String password) {
    RegExp regExp = RegExp(
        '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*/(){}._-`+=\'|?;:<>]).{8,32}\$');
    return (regExp.hasMatch(password) || password.isEmpty);
  }

  /// Check password if length > 8
  static bool checkPasswordLength(String password) {
    return password.length >= 8 && password.length <= 32;
  }

  static bool nameValidator(String name) {
    RegExp regExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    return regExp.hasMatch(name);
  }

  ///
  static String? passwordValidator(String password) {
    if (password.isEmpty) {
      return S.current.enter_your_password;
    } else if (!checkPasswordLength(password)) {
      return S.current.message_policy_of_password;
    }
    return null;
  }

  static String? passwordSignUpValidator(String password, String email) {
    if (password.isEmpty) {
      return S.current.enter_your_password;
    } else if (!checkPasswordLength(password)) {
      return S.current.message_policy_of_password;
    } else if (isEmail(email)) {
      final emailSplit = email.split('@')[0];
      if (emailSplit.toLowerCase() == password.toLowerCase()) {
        return S.current.message_policy_of_password;
      }
      return null;
    }
    return null;
  }

  static String? resetPasswordValidator(String password) {
    if (password.isEmpty) {
      return S.current.message_please_enter_new_password;
    } else if (!checkPasswordLength(password)) {
      return S.current.message_policy_of_password;
    }
    return null;
  }

  /// show validate current password
  static String? currentPasswordValidator(String password) {
    if (password.isEmpty) {
      return S.current.message_enter_current_password;
    } else if (!checkPasswordLength(password)) {
      return S.current.message_policy_of_password;
    }
    return null;
  }

  /// show error text when pass length < 8
  static String? newPasswordValidator(String newPassword, String oldPassword) {
    if (newPassword.isEmpty) {
      return S.current.message_please_enter_new_password;
    } else {
      if (!checkPasswordLength(newPassword)) {
        return S.current.message_policy_of_password;
      } else if (newPassword == oldPassword) {
        return S.current.new_pass_not_identical_with_old_pass;
      }
    }
    return null;
  }

  /// show error text when email invalid
  static String? emailValidator(String email) {
    if (email.isEmpty) {
      return S.current.enter_your_email;
    } else if (!Utils.isEmail(email)) {
      return S.current.message_please_enter_valid_email;
    } else if (email.length > 255) {
      return S.current.message_enter_email_within_255_characters;
    }
    return null;
  }

  static String? emptyValidator(String text) {
    if (text.isEmpty) {
      return S.current.enter_your_username_or_email;
    }
    return null;
  }

  /// show error text when current email invalid
  static String? currentEmailValidator(String email, String currentEmail) {
    if (email.isEmpty) {
      return S.current.message_please_enter_current_email_address;
    } else if (email != currentEmail) {
      return S.current.message_current_email_is_incorrect;
    } else if (email.length > 255) {
      return S.current.message_enter_email_within_255_characters;
    }
    return null;
  }

  /// show error text when new email invalid
  static String? newEmailValidator(String email, String newEmail) {
    if (email.isEmpty) {
      return S.current.message_please_enter_new_email_address;
    } else if (!Utils.isEmail(email)) {
      return S.current.message_please_enter_valid_email;
    } else if (email == newEmail) {
      return S.current.message_new_email_must_not_the_same_old_email;
    } else if (email.length > 255) {
      return S.current.message_enter_email_within_255_characters;
    }
    return null;
  }

  static String? validateRePassword(String rePassword, String password) {
    if (rePassword.isEmpty) {
      return S.current.message_please_enter_password_confirmation;
    } else if (!checkPasswordLength(password)) {
      return S.current.message_policy_of_password;
    } else if (password != rePassword) {
      return S.current.passwords_are_not_the_same;
    }
    return null;
  }

  /// show error text when name invalid
  static String? nameInvalid(String name) {
    if (name.trim().isEmpty) {
      return S.current.message_please_enter_name;
    } else if (name.length > 50) {
      return S.current.message_enter_name_within_50_characters;
    } else if (nameValidator(name)) {
      return S.current.message_error_name_not_contain_number;
    }
    return null;
  }

  // /// show error text when last name invalid
  // static String? lastNameInvalid(String name) {
  //   if (name.trim().isEmpty) {
  //     return S.current.message_please_enter_last_name;
  //   } else if (name.length > 50) {
  //     return S.current.message_enter_last_name_within_50_characters;
  //   } else if (nameValidator(name)) {
  //     return S.current.message_error_name_not_contain_number;
  //   }
  //   return null;
  // }

  ///Color
  static Color? getColorFromHex(String? hexColor) {
    hexColor = (hexColor ?? '').replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }

  static String? getHexFromColor(Color color) {
    String colorString = color.toString(); // Color(0x12345678)
    String valueString = colorString.split('(0x')[1].split(')')[0];
    return valueString;
  }

  ///reSize Image
  static Future<File?> resizeImage(
    File file, {
    Function(File)? onSubmitImage,
    required num imageSize,
    Function? onErrorImage,
  }) async {
    final dir = await getTemporaryDirectory();

    /// Create a temporary path to save the resized file
    /// Nên thay DateTime.now() bằng cái gì đó cá nhân và cụ thể hơn như id người dùng chẳng hạn
    final targetPath = "${dir.absolute.path}/${"temp${DateTime.now()}.jpg"}";
    File? result;
    for (int i = 95; i > 5; i -= 5) {
      result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, targetPath,
          quality: i);
      final bytes = (result?.lengthSync());
      final mb = ((bytes ?? 0) / 1024.0) / 1024.0;
      if (mb <= imageSize) {
        onSubmitImage?.call(result!);
        return result;
      }
    }
    onErrorImage?.call();
    return result;
  }
}
