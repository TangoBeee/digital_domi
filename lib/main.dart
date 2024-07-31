import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:digital_domi/providers/map_visibility_controller.dart';
import 'package:digital_domi/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapVisibilityController()),
      ],
      child: MaterialApp(
        title: 'Digital Domi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
