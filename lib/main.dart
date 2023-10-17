import 'package:flutter/material.dart';
import 'package:my_version_of_watch_and_select/add_page.dart';
import 'package:my_version_of_watch_and_select/home_page.dart';
import 'package:my_version_of_watch_and_select/provider_class.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => BreadCrumbProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            titleTextStyle: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          useMaterial3: true,
        ),
        routes: {
          '/add_page': (context) => const AddPage(),
        },
        home: const HomePage());
  }
}
