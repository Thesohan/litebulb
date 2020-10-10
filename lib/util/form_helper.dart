/// This class contains all form validators.

class FormHelper {
  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter valid email address.';
    } else {
      return null;
    }
  }

  static String validateFirstName(String value) {
    if (value == null || value == '') {
      return 'First name is required.';
    } else {
      return null;
    }
  }

  static String validateLastName(String value) {
    if (value == null || value == '') {
      return 'Last name is required.';
    } else {
      return null;
    }
  }

  static String validatePassword(String value) {
    if (value.length < 5) {
      return 'Password should be greater than 4 characters.';
    } else {
      return null;
    }
  }
}
