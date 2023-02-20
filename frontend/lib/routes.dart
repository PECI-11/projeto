import 'package:flutter/material.dart';
import 'package:frontend/auth/login_turista.dart';

class FrontendRouter {
  static const homePage = '/';
  static const loginTurista = '/auth/login_turista';
  //static const user_Empresa = '/auth/user_empresa';

  static Map<String, WidgetBuilder> routes = {
    loginTurista: (BuildContext context) => const LoginTurista(),
    //user_Empresa: (BuildContext context) => const UserEmpresa();
  };
}