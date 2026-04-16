import 'package:bloc_pattern/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../views/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.counterScreen:
        return MaterialPageRoute(builder: (context) => const CounterScreen());
      case RoutesName.switchExampleScreen:
        return MaterialPageRoute(builder: (context) => const SwitchExample());
      case RoutesName.imagePickerScreen:
        return MaterialPageRoute(builder: (context) => const ImagePickerScreen());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text("No route generated"),
              ),
            );
          },
        );
    }
  }
}
