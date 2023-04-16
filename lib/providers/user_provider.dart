import 'package:flutter/material.dart';
import 'package:wordfight/models/user.dart';
import 'package:wordfight/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  User? get getUser => _user;

  Future<void> setUserInProvider() async {
    _user = await AuthMethods().getUserDetails();
    notifyListeners();
  }
}
