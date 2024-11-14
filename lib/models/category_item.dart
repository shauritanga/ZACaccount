import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class CategoryItem extends Equatable {
  CategoryItem({
    String? id,
    this.category = "",
    this.description = "",
    this.quantity = 0,
    this.rate = 0,
    this.unitType = "",
    this.amount = 0,
    this.paymentAccount,
    this.customerId = "",
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String category;
  final String description; // what did you pay for?
  final int quantity;
  final double rate;
  final String unitType;
  final double amount;
  final String? paymentAccount;
  final String customerId;

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] as String?,
      category: json['category'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      rate: json['rate'] as double,
      unitType: json['unitType'] as String,
      amount: json['amount'] as double,
      paymentAccount: json['paymentAccount'] as String?,
      customerId: json['customerId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'quantity': quantity,
      'rate': rate,
      'unitType': unitType,
      'amount': amount,
      'paymentAccount': paymentAccount,
      'customerId': customerId,
    };
  }

  @override
  List<Object?> get props => [id, customerId];
}
