// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class BreadCrumb {
  //Since I want isActive to be changed so I won't mark it as final
  late bool _isActive;
  final String name;
  final String uuid;

  BreadCrumb({
    required this.name,
  })  : uuid = const Uuid().v4(),
        _isActive = false;

  bool get isActive => _isActive;

  String get title => name + (_isActive ? ' > ' : '');

  void activate() {
    _isActive = true;
  }

  //Using uuid for equality is good practice
  @override
  bool operator ==(covariant BreadCrumb other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  //Good practice to create unmodifiable listView if you want a read-only version of a list
  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items);

  void add(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.activate();
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
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

class BreadCrumbWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> breadCrumbs;
  const BreadCrumbWidget({
    Key? key,
    required this.breadCrumbs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumbs.map(
        (breadCrumb) {
          return Text(
            breadCrumb.title,
            style: TextStyle(
              color: breadCrumb.isActive ? Colors.blue : Colors.black,
            ),
          );
        },
      ).toList(),
    );
  }
}

class AddBreadCrumbPage extends StatefulWidget {
  const AddBreadCrumbPage({super.key});

  @override
  State<AddBreadCrumbPage> createState() => _AddBreadCrumbPageState();
}

class _AddBreadCrumbPageState extends State<AddBreadCrumbPage> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Add new bread crumb',
        ),
      ),
      body: Column(
        children: [
          TextField(
            autofocus: true,
            controller: controller,
            decoration: const InputDecoration(
                hintText: 'Enter an new bread crumb here...'),
          ),
          TextButton(
              onPressed: () {
                final text = controller.text;
                if (text.isNotEmpty) {
                  context.read<BreadCrumbProvider>().add(BreadCrumb(name: text));
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'))
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<BreadCrumbProvider>(
              builder: (context, value, child) {
                return BreadCrumbWidget(
                  breadCrumbs: value.items,
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/new',
                );
              },
              child: const Text(
                'Add new bread crumb',
              ),
            ),
            TextButton(
              //Using read() when you just want a snapshot from the stream of changes
              // since read() using assign false to listen property in Provider.of()
              onPressed: () => context.read<BreadCrumbProvider>().reset(),
              child: const Text(
                'Reset',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
