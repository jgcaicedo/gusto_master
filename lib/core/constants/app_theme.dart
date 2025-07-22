import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Clase que define los temas visuales de la aplicación (colores, estilos, etc).
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[100],
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold
      )
    ),
  );

}