// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_banking/infrastructure/infrastructure.dart';
import 'package:mobile_banking/infrastructure/repository/auth/auth.dart';

import 'package:mobile_banking/main.dart';

void main() {
  test("Password validation", () {
    var f = InputValidationMixin();
    bool actual = f.isPasswordValid("1234");
    expect(actual, false);
  });
}

class InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }
}
