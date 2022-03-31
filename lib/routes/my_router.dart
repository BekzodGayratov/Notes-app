import 'package:flutter/material.dart';
import 'package:notes/screens/home_page.dart';

class MyRouter {
  Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomePage());
    }
    return null;
  }
}
