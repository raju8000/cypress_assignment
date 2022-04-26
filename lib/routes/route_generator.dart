import 'package:cypress_task/Screen/screen_gallery.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Gallery.routeName:
        return MaterialPageRoute(
          builder: (_) => const Gallery(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}