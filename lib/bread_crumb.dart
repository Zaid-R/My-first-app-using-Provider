// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class BreadCrumb {
  final String title;
  final String uuid;
  BreadCrumb({
    required this.title,
  }) : uuid = const Uuid().v4();
  
  @override
  bool operator == (covariant BreadCrumb other) => uuid == other.uuid;
  
  @override
  int get hashCode => uuid.hashCode;
  
}
