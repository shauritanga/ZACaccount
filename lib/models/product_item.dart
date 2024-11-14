import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ProductItem extends Equatable {
  final String id;
  final String item;
  final String sku;
  final String description;
  final int quantity;
  final int rate;
  final String unitType;
  final double amount;
  final String? paymentAccount;
  final String customerId;
  final DateTime processingDate;

  ProductItem({
    String? id,
    this.item = "",
    this.sku = "",
    this.description = "",
    this.quantity = 0,
    this.rate = 0,
    this.unitType = "",
    this.amount = 0.0,
    this.paymentAccount,
    this.customerId = "",
    DateTime? processingDate,
  })  : id = id ?? const Uuid().v4(),
        processingDate = processingDate ?? DateTime.now();

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] as String?,
      item: json['item'] as String,
      sku: json['sku'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      rate: json['rate'] as int,
      unitType: json['unitType'] as String,
      amount: json['amount'] as double,
      paymentAccount: json['paymentAccount'] as String?,
      customerId: json['customerId'] as String,
      processingDate: DateTime.parse(json['processingDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item,
      'sku': sku,
      'description': description,
      'quantity': quantity,
      'rate': rate,
      'unitType': unitType,
      'amount': amount,
      'paymentAccount': paymentAccount,
      'customerId': customerId,
      'processingDate': processingDate.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, item, amount];
}
