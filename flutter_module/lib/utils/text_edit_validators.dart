abstract class TextEditValidators {
  static String isValidateEmail(String value) {
    return _emailValidation(value) ? "isValidateEmail" : null;
  }

  static String isOptionalValidateEmail(String value) {
    return value != ""
        ? _emailValidation(value)
            ? "isOptionalValidateEmail"
            : null
        : null;
  }

  static String isNotEmpty(String value) {
    return value == "" ? "isNotEmpty" : null;
  }

  static String isMinLength(String value) {
    return value.length < 2 ? "isMinLength" : null;
  }

  static String isNotNeeded(String value) {
    return null;
  }

  static bool _emailValidation(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return !regex.hasMatch(value);
  }

  static String passwordStrength(String value) {
    String messageError;
    if (value.length == 0) {
      messageError = "passwordStrength";
    } else if (value.length < 8) {
      messageError = "Enter at least 8 characters";
    } else if (value.contains(" ")) {
      messageError = "Must not have blank spaces";
    } else {
      Pattern pattern =
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-_\.:,;!\?#/\\"\()\{\}\[\]\*\+])';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value)) {
        messageError =
            "Need uppercase, lowercase, character -_.:,;!?#/\"(){}[]*+";
      } else {
        messageError = null;
      }
    }
    return messageError;
  }
}
