import 'package:flutter/material.dart';
import 'package:studentregisterweek5/db/functions.dart';
import 'package:studentregisterweek5/screen/homescreen.dart';

Future< void> main()async {
 WidgetsFlutterBinding.ensureInitialized();
 initializeDatabase();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
