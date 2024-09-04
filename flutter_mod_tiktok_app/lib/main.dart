import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'transit_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '讀琴',
      debugShowCheckedModeBanner: false, //去掉右上角的紅色橫條
      theme: themeData,
      home: const TransitPage(),
    );
  }
}
