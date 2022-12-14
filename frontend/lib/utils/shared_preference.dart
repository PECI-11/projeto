import 'package:frontend/auth/user_empresa.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class userPreferences {

  Future<bool> saveUser (userEmpresa user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();




  }

  Future<userEmpresa> getUser() async {
    final SharedPreferences prefs
  }

}