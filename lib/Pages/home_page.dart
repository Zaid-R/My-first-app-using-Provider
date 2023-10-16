import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_provider_app/Providers/bread_crumb_provider.dart';
import 'package:testing_provider_app/widgets/bread_crumb_widget.dart';

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
