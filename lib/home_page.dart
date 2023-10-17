import 'package:flutter/material.dart';
import 'package:my_version_of_watch_and_select/provider_class.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BreadCrumbProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Wrap(
              children: provider.items.map((item) {
                final title = item.title;
                bool isLast = item == provider.items.last;
                return Text(
                  title + (isLast ? '' : ' > '),
                  style: TextStyle(
                      color: isLast ? Colors.black : Colors.blueAccent),
                );
              }).toList(),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/add_page'),
              child: const Text('Add new bread crumb'),
            ),
            TextButton(
              onPressed: () => context.read<BreadCrumbProvider>().reset(),
              child: const Text('Rest'),
            ),
          ],
        ),
      ),
    );
  }
}
