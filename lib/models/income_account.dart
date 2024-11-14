import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class IncomeAccount {
  String id;
  String name;

  IncomeAccount({
    String? id,
    required this.name,
  }) : id = id ?? const Uuid().v4();

  factory IncomeAccount.fromJson(Map<String, dynamic> json) {
    return IncomeAccount(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  factory IncomeAccount.fromDocument(DocumentSnapshot json) {
    return IncomeAccount(
      id: json.id,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
