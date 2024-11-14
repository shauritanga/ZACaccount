import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ExpenseAccount {
  final String id;
  final String name;

  ExpenseAccount({
    String? id,
    required this.name,
  }) : id = id ?? const Uuid().v4();

  factory ExpenseAccount.fromJson(Map<String, dynamic> json) {
    return ExpenseAccount(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  factory ExpenseAccount.fromDocument(DocumentSnapshot json) {
    return ExpenseAccount(
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
