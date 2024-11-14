import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ExpensesCategory extends Equatable {
  final String id;
  final String name;
  final String image;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExpensesCategory({
    String? id,
    required this.name,
    required this.image,
    required this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ExpensesCategory.fromJson(Map<String, dynamic> json) {
    return ExpensesCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, name, description, createdAt];
}
