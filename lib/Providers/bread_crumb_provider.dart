import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:testing_provider_app/models/bread_crumb.dart';

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
