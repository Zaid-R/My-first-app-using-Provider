
import 'package:flutter/material.dart';
import 'package:my_version_of_watch_and_select/provider_class.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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
        title: const Text('Add Page'),
      ),
      body: Center(
          child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Enter new title ...',
            ),
            controller: controller,
          ),
          TextButton(
            onPressed: () {
              final text = controller.text;
              if(text.isNotEmpty){
              final provider = context.read<BreadCrumbProvider>();
               provider.add(text);
               Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      )),
    );
  }
}
