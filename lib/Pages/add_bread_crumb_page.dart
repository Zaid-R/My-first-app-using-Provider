import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_provider_app/Providers/bread_crumb_provider.dart';
import 'package:testing_provider_app/models/bread_crumb.dart';

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
                  context
                      .read<BreadCrumbProvider>()
                      .add(BreadCrumb(name: text));
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'))
        ],
      ),
    );
  }
}
