import 'package:el_mago/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar এর রঙ
      statusBarIconBrightness:
          Brightness.light, // Android এর জন্য আইকনের রঙ (light/dark)
      statusBarBrightness:
          Brightness.dark, // iOS এর জন্য (dark মানে light icons)
    ),
  );
  runApp(const MyApp());
}
