import 'package:uuid/uuid.dart';

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
