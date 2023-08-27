import 'package:flutter/material.dart';

import '../../theme/color_schemes.dart';
import 'decorations/input_decoration.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    inputDecorationTheme: lightInputDecorationTheme);

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    brightness: Brightness.dark,
    inputDecorationTheme: lightInputDecorationTheme);
