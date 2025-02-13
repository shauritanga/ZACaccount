import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:zaccount/models/product_category.dart';

class ProductInfo {
  String id;
  String name;
  String image;
  String description;
  String sku;
  ProductCategory category;
  String type;
  DateTime asOfDate;
  int reOrderPoint;
  bool? lowStockStatus;
  int stockQuantity;
  double salesPrice;
  String unitType;
  String incomeAccount;
  double salesTax;
  String purchasingInformation;
  double cost;
  String expenseAccount;
  String preferredVendor;
  DateTime createdAt;
  DateTime updatedAt;
  ProductInfo({
    String? id,
    this.name = "",
    this.image = "",
    this.description = "",
    this.sku = "",
    ProductCategory? category,
    this.type = "",
    DateTime? asOfDate,
    this.reOrderPoint = 0,
    this.lowStockStatus = false,
    this.stockQuantity = 0,
    this.salesPrice = 0.0,
    this.unitType = "",
    this.incomeAccount = "",
    this.salesTax = 0.0,
    this.purchasingInformation = "",
    this.cost = 0.0,
    this.expenseAccount = "",
    this.preferredVendor = "",
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        asOfDate = asOfDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        category = category ?? ProductCategory();

  ProductInfo copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    String? sku,
    ProductCategory? category,
    String? type,
    DateTime? asOfDate,
    int? reOrderPoint,
    ValueGetter<bool?>? lowStockStatus,
    int? stockQuantity,
    double? salesPrice,
    String? unitType,
    String? incomeAccount,
    double? salesTax,
    String? purchasingInformation,
    double? cost,
    String? expenseAccount,
    String? preferredVendor,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      type: type ?? this.type,
      asOfDate: asOfDate ?? this.asOfDate,
      reOrderPoint: reOrderPoint ?? this.reOrderPoint,
      lowStockStatus:
          lowStockStatus != null ? lowStockStatus() : this.lowStockStatus,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      salesPrice: salesPrice ?? this.salesPrice,
      unitType: unitType ?? this.unitType,
      incomeAccount: incomeAccount ?? this.incomeAccount,
      salesTax: salesTax ?? this.salesTax,
      purchasingInformation:
          purchasingInformation ?? this.purchasingInformation,
      cost: cost ?? this.cost,
      expenseAccount: expenseAccount ?? this.expenseAccount,
      preferredVendor: preferredVendor ?? this.preferredVendor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'sku': sku,
      'category': category.toJson(),
      'type': type,
      'asOfDate': asOfDate.millisecondsSinceEpoch,
      'reOrderPoint': reOrderPoint,
      'lowStockStatus': lowStockStatus,
      'stockQuantity': stockQuantity,
      'salesPrice': salesPrice,
      'unitType': unitType,
      'incomeAccount': incomeAccount,
      'salesTax': salesTax,
      'purchasingInformation': purchasingInformation,
      'cost': cost,
      'expenseAccount': expenseAccount,
      'preferredVendor': preferredVendor,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ProductInfo.fromDocument(DocumentSnapshot map) {
    return ProductInfo(
      id: map.id,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      sku: map['sku'] ?? '',
      category:
          ProductCategory.fromJson(map['category'] as Map<String, dynamic>),
      type: map['type'] ?? '',
      asOfDate: DateTime.fromMillisecondsSinceEpoch(map['asOfDate']),
      reOrderPoint: map['reOrderPoint']?.toInt() ?? 0,
      lowStockStatus: map['lowStockStatus'],
      stockQuantity: map['stockQuantity']?.toInt() ?? 0,
      salesPrice: map['salesPrice']?.toDouble() ?? 0.0,
      unitType: map['unitType'] ?? '',
      incomeAccount: map['incomeAccount'] ?? '',
      salesTax: map['salesTax']?.toDouble() ?? 0.0,
      purchasingInformation: map['purchasingInformation'] ?? '',
      cost: map['cost']?.toDouble() ?? 0.0,
      expenseAccount: map['expenseAccount'] ?? '',
      preferredVendor: map['preferredVendor'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductInfo.fromJson(String source) =>
      ProductInfo.fromDocument(json.decode(source));

  @override
  String toString() {
    return 'ProductInfo(id: $id, name: $name, image: $image, description: $description, sku: $sku, category: $category, type: $type, asOfDate: $asOfDate, reOrderPoint: $reOrderPoint, lowStockStatus: $lowStockStatus, stockQuantity: $stockQuantity, salesPrice: $salesPrice, unitType: $unitType, incomeAccount: $incomeAccount, salesTax: $salesTax, purchasingInformation: $purchasingInformation, cost: $cost, expenseAccount: $expenseAccount, preferredVendor: $preferredVendor, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductInfo &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.description == description &&
        other.sku == sku &&
        other.category == category &&
        other.type == type &&
        other.asOfDate == asOfDate &&
        other.reOrderPoint == reOrderPoint &&
        other.lowStockStatus == lowStockStatus &&
        other.stockQuantity == stockQuantity &&
        other.salesPrice == salesPrice &&
        other.unitType == unitType &&
        other.incomeAccount == incomeAccount &&
        other.salesTax == salesTax &&
        other.purchasingInformation == purchasingInformation &&
        other.cost == cost &&
        other.expenseAccount == expenseAccount &&
        other.preferredVendor == preferredVendor &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        description.hashCode ^
        sku.hashCode ^
        category.hashCode ^
        type.hashCode ^
        asOfDate.hashCode ^
        reOrderPoint.hashCode ^
        lowStockStatus.hashCode ^
        stockQuantity.hashCode ^
        salesPrice.hashCode ^
        unitType.hashCode ^
        incomeAccount.hashCode ^
        salesTax.hashCode ^
        purchasingInformation.hashCode ^
        cost.hashCode ^
        expenseAccount.hashCode ^
        preferredVendor.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
