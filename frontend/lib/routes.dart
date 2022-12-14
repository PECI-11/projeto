import 'package:flutter/material.dart';
import 'package:frontend/pages/login_turista.dart';

class FrontendRouter {
  static const homePage = '/';
  static const loginTurista = '/login_turista';

  static Map<String, WidgetBuilder> routes = {
    loginTurista: (BuildContext context) => const LoginTurista(),
  };
}