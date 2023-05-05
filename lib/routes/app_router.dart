
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/ui/screens/login.dart';


class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
        break;

      default:
        return null;
    }
  }
}
