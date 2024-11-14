import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Receipt extends Equatable {
  final String id;
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final String description;
  final String paymentAccount;
  final int amount;
  final String category;

  Receipt({
    String? id,
    required this.name,
    required this.createdBy,
    DateTime? createdAt,
    required this.description,
    required this.paymentAccount,
    this.amount = 0,
    required this.category,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      id: json['id'] as String,
      name: json['name'] as String,
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String,
      paymentAccount: json['paymentAccount'] as String,
      amount: json['amount'] as int,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'description': description,
      'paymentAccount': paymentAccount,
      'amount': amount,
      'category': category,
    };
  }

  @override
  List<Object?> get props => [id, name, createdBy, createdAt];
}
