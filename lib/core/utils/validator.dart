import 'dart:core';

class Validator {
  // Function to validate email
  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp('$pattern');
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else if (value.isEmpty) {
      return 'Email is required';
    } else {
      return null;
    }
  }

  // Function to validate name
  String? validateName(String value) {
    if (value.isEmpty) return 'Name is required';
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters';
    } else if (value.length < 3) {
      return 'Name should be more than 3 characters';
    }
    return null;
  }

  // Function to validate ID
  String? validateID(String value) {
    if (value.length != 7) return 'ID must consist of 7 digits';
    return null;
  }

  // Function to validate password
  String? validatePassword(String value) {
    if (value.length < 8) {
      return 'Password should be more than 8 characters';
    } else if (value.isEmpty) {
      return 'Password is required';
    } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Password should contain at least one lowercase letter';
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password should contain at least one uppercase letter';
    } else if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
      return 'Password should contain at least one number';
    } else if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
      return 'Password should contain at least one special character';
    } else {
      return null;
    }
  }

  String? validatePasswordLogin(String value) {
    if (value.length < 8) {
      return 'Password should be more than 8 characters';
    } else if (value.isEmpty) {
      return 'Password is required';
    } else {
      return null;
    }
  }
}
