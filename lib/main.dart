import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_provider_app/Pages/add_bread_crumb_page.dart';
import 'package:testing_provider_app/Pages/home_page.dart';
import 'package:testing_provider_app/Providers/bread_crumb_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This ChangeNotifierProvider here is wrapping itself around the entire app
    // meaning that the creation of BreadCrumbProvider below
    // will cause the provider to be available in all BuildContext essantially in the intire app
    // meaning it's available to all descendants of the app
    // and this is why BuildContext is so important, it's way for you to do dependency injection
    // it's kind of invisible dependency injection in Flutter
    return ChangeNotifierProvider(
      create: (_) => BreadCrumbProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
        routes: {
          '/new': (context) => const AddBreadCrumbPage(),
        },
      ),
    );
  }
}
