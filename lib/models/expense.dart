import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:zaccount/models/category_item.dart';
import 'package:zaccount/models/product_item.dart';

class Expense {
  final String id;
  final String payee;
  final String paymentAccount;
  final DateTime paymentDate;
  final DateTime dueDate;
  final String paymentMethod;
  final String referenceNo;
  final String permitNo;
  final String expenseStatus;
  final List<CategoryItem> categoryItems;
  final List<ProductItem> productItems;
  final double totalAmount;
  final String memo;
  final List<String> attachments;
  final String currencyType;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Default constructor
  Expense({
    String? id,
    DateTime? paymentDate,
    DateTime? dueDate,
    List<CategoryItem>? categoryItems,
    List<ProductItem>? productItems,
    List<String>? attachments,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.payee = '',
    this.paymentAccount = '',
    this.paymentMethod = '',
    this.referenceNo = '',
    this.permitNo = '',
    this.expenseStatus = '',
    this.totalAmount = 0,
    this.memo = '',
    this.currencyType = '',
  })  : id = id ?? const Uuid().v4(),
        paymentDate = paymentDate ?? DateTime.now(),
        dueDate = dueDate ?? DateTime.now(),
        categoryItems = categoryItems ?? [],
        productItems = productItems ?? [],
        attachments = attachments ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'payee': payee,
      'paymentAccount': paymentAccount,
      'paymentDate': paymentDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'referenceNo': referenceNo,
      'permitNo': permitNo,
      'expenseStatus': expenseStatus,
      'categoryItems': categoryItems.map((item) => item.toJson()).toList(),
      'productItems': productItems.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'memo': memo,
      'attachments': attachments,
      'currencyType': currencyType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      payee: json['payee'],
      paymentAccount: json['paymentAccount'],
      paymentDate: DateTime.parse(json['paymentDate']),
      dueDate: DateTime.parse(json['dueDate']),
      paymentMethod: json['paymentMethod'],
      referenceNo: json['referenceNo'],
      permitNo: json['permitNo'],
      expenseStatus: json['expenseStatus'],
      categoryItems: List<CategoryItem>.from(
          json['categoryItems'].map((item) => CategoryItem.fromJson(item))),
      productItems: List<ProductItem>.from(
          json['productItems'].map((item) => ProductItem.fromJson(item))),
      totalAmount: json['totalAmount'],
      memo: json['memo'],
      attachments: List<String>.from(json['attachments']),
      currencyType: json['currencyType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory Expense.fromDocument(DocumentSnapshot json) {
    return Expense(
      id: json.id,
      payee: json['payee'],
      paymentAccount: json['paymentAccount'],
      paymentDate: DateTime.parse(json['paymentDate']),
      dueDate: DateTime.parse(json['dueDate']),
      paymentMethod: json['paymentMethod'],
      referenceNo: json['referenceNo'],
      permitNo: json['permitNo'],
      expenseStatus: json['expenseStatus'],
      categoryItems: List<CategoryItem>.from(
          json['categoryItems'].map((item) => CategoryItem.fromJson(item))),
      productItems: List<ProductItem>.from(
          json['productItems'].map((item) => ProductItem.fromJson(item))),
      totalAmount: json['totalAmount'],
      memo: json['memo'],
      attachments: List<String>.from(json['attachments']),
      currencyType: json['currencyType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Expense copyWith({
    String? id,
    String? payee,
    String? paymentAccount,
    DateTime? paymentDate,
    DateTime? dueDate,
    String? paymentMethod,
    String? referenceNo,
    String? permitNo,
    String? expenseStatus,
    List<CategoryItem>? categoryItems,
    List<ProductItem>? productItems,
    double? totalAmount,
    String? memo,
    List<String>? attachments,
    String? currencyType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Expense(
      id: id ?? this.id,
      payee: payee ?? this.payee,
      paymentAccount: paymentAccount ?? this.paymentAccount,
      paymentDate: paymentDate ?? this.paymentDate,
      dueDate: dueDate ?? this.dueDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      referenceNo: referenceNo ?? this.referenceNo,
      permitNo: permitNo ?? this.permitNo,
      expenseStatus: expenseStatus ?? this.expenseStatus,
      categoryItems: categoryItems ?? this.categoryItems,
      productItems: productItems ?? this.productItems,
      totalAmount: totalAmount ?? this.totalAmount,
      memo: memo ?? this.memo,
      attachments: attachments ?? this.attachments,
      currencyType: currencyType ?? this.currencyType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'payee': payee,
      'paymentAccount': paymentAccount,
      'paymentDate': paymentDate.millisecondsSinceEpoch,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'paymentMethod': paymentMethod,
      'referenceNo': referenceNo,
      'permitNo': permitNo,
      'expenseStatus': expenseStatus,
      'categoryItems': categoryItems.map((x) => x.toJson()).toList(),
      'productItems': productItems.map((x) => x.toJson()).toList(),
      'totalAmount': totalAmount,
      'memo': memo,
      'attachments': attachments,
      'currencyType': currencyType,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Expense.fromMap(String id, Map<String, dynamic> map) {
    return Expense(
      id: id,
      payee: map['payee'] as String,
      paymentAccount: map['paymentAccount'] as String,
      paymentDate:
          DateTime.fromMillisecondsSinceEpoch(map['paymentDate'] as int),
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
      paymentMethod: map['paymentMethod'] as String,
      referenceNo: map['referenceNo'] as String,
      permitNo: map['permitNo'] as String,
      expenseStatus: map['expenseStatus'] as String,
      categoryItems: List<CategoryItem>.from(
        (map['categoryItems'] as List<int>).map<CategoryItem>(
          (x) => CategoryItem.fromJson(x as Map<String, dynamic>),
        ),
      ),
      productItems: List<ProductItem>.from(
        (map['productItems'] as List<int>).map<ProductItem>(
          (x) => ProductItem.fromJson(x as Map<String, dynamic>),
        ),
      ),
      totalAmount: map['totalAmount'] as double,
      memo: map['memo'] as String,
      attachments: List<String>.from((map['attachments'] as List<String>)),
      currencyType: map['currencyType'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  @override
  String toString() {
    return 'Expense(id: $id, payee: $payee, paymentAccount: $paymentAccount, paymentDate: $paymentDate, dueDate: $dueDate, paymentMethod: $paymentMethod, referenceNo: $referenceNo, permitNo: $permitNo, expenseStatus: $expenseStatus, categoryItems: $categoryItems, productItems: $productItems, totalAmount: $totalAmount, memo: $memo, attachments: $attachments, currencyType: $currencyType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.payee == payee &&
        other.paymentAccount == paymentAccount &&
        other.paymentDate == paymentDate &&
        other.dueDate == dueDate &&
        other.paymentMethod == paymentMethod &&
        other.referenceNo == referenceNo &&
        other.permitNo == permitNo &&
        other.expenseStatus == expenseStatus &&
        listEquals(other.categoryItems, categoryItems) &&
        listEquals(other.productItems, productItems) &&
        other.totalAmount == totalAmount &&
        other.memo == memo &&
        listEquals(other.attachments, attachments) &&
        other.currencyType == currencyType &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        payee.hashCode ^
        paymentAccount.hashCode ^
        paymentDate.hashCode ^
        dueDate.hashCode ^
        paymentMethod.hashCode ^
        referenceNo.hashCode ^
        permitNo.hashCode ^
        expenseStatus.hashCode ^
        categoryItems.hashCode ^
        productItems.hashCode ^
        totalAmount.hashCode ^
        memo.hashCode ^
        attachments.hashCode ^
        currencyType.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
