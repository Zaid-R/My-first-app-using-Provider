// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:my_version_of_watch_and_select/bread_crumb.dart';

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items =[];
  
  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items);
  
  void add(String item){
    _items.add(BreadCrumb(title: item));
    notifyListeners();
  }
   
  void reset(){
    _items.clear();
    notifyListeners();
  }

}
