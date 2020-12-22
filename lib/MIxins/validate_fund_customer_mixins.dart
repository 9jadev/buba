// import 'package:email_validator/email_validator.dart';

class FundCustomerValidationMixin {
  // String _password;

  String validatefirstname(String value) {
    if (value.isEmpty) {
      return 'First Name is requred';
    } else {
      return null;
    }
  }

  String validatePhone(String value) {
    int len = value.length;
    if (value.isEmpty) {
      return 'Phone number is requred';
    }
    if (len < 11) {
      return 'Phone number should not be less than 11 characters';
    }
    return null;
  }

  String validatelastname(String value) {
    if (value.isEmpty) {
      return 'Last Name is requred';
    } else {
      return null;
    }
  }

  String validatephone(String value) {
    if (value.isEmpty) {
      return 'Last Name is requred';
    } else {
      return null;
    }
  }

  // String validateEmail(String value) {
  //   final bool isValid = EmailValidator.validate(value);
  //   return isValid ? null : 'Email is required';
  // }

  // String validateAbout(String value) {
  //   if (value.isEmpty) {
  //     return 'About is requred';
  //   }

  //   int len = value.length;
  //   if (len < 50) {
  //     return 'About must be between 50 to 600 characters';
  //   }
  //   return null;
  // }

  // String validatefirstname(String value) {
  //   if (value.isEmpty) {
  //     return 'Firstname is requred';
  //   } else {
  //     _password = value;
  //     return null;
  //   }
  // }

  // String validatelastname(String value) {
  //   if (value.isEmpty) {
  //     return 'Lastname is requred';
  //   } else {
  //     _password = value;
  //     return null;
  //   }
  // }

  // String validateConfirmpassword(String value) {
  //   // print(value);
  //   if (value.isEmpty) {
  //     return 'Confirm Password is requred';
  //   }
  //   if (_password != value) {
  //     return 'Password and Confirm Password should be same';
  //   }
  //   return null;
  // }
}
