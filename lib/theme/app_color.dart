import 'package:flutter/material.dart';

class AppColors {
  static Color primaryGreen = Color.fromARGB(255, 52, 137, 55);
  static Color greenLight = Color(0xFF93DA97);

  static Color background(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color card(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color text(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

  static Color icon(BuildContext context) =>
      Theme.of(context).iconTheme.color ?? Colors.black;
}
