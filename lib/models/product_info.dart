// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:zaccount/models/product_category.dart';

class ProductInfo {
  String id;
  String name;
  String image;
  String description;
  String sku;
  List<ProductCategory> category;
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
    this.category = const [],
    this.type = "",
    DateTime? asOfDate,
    this.reOrderPoint = 0,
    this.lowStockStatus = false,
    this.stockQuantity = 0,
    this.salesPrice = 0,
    this.unitType = "",
    this.incomeAccount = "",
    this.salesTax = 0,
    this.purchasingInformation = "",
    this.cost = 0,
    this.expenseAccount = "",
    this.preferredVendor = "",
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        asOfDate = asOfDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      sku: json['sku'],
      category: (json['category'] as List<dynamic>)
          .map((e) => ProductCategory.fromJson(e))
          .toList(),
      type: json['type'],
      asOfDate: DateTime.parse(json['asOfDate']),
      reOrderPoint: json['reOrderPoint'],
      lowStockStatus: json['lowStockStatus'],
      stockQuantity: json['stockQuantity'],
      salesPrice: json['salesPrice'],
      unitType: json['unitType'],
      incomeAccount: json['incomeAccount'],
      salesTax: json['salesTax'],
      purchasingInformation: json['purchasingInformation'],
      cost: json['cost'],
      expenseAccount: json['expenseAccount'],
      preferredVendor: json['preferredVendor'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory ProductInfo.fromDocument(DocumentSnapshot json) {
    return ProductInfo(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      sku: json['sku'],
      category: (json['category'] as List<dynamic>)
          .map((e) => ProductCategory.fromJson(e))
          .toList(),
      type: json['type'],
      asOfDate: DateTime.parse(json['asOfDate']),
      reOrderPoint: json['reOrderPoint'],
      lowStockStatus: json['lowStockStatus'],
      stockQuantity: json['stockQuantity'],
      salesPrice: json['salesPrice'],
      unitType: json['unitType'],
      incomeAccount: json['incomeAccount'],
      salesTax: json['salesTax'],
      purchasingInformation: json['purchasingInformation'],
      cost: json['cost'],
      expenseAccount: json['expenseAccount'],
      preferredVendor: json['preferredVendor'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'sku': sku,
      'category': category.map((e) => e.toJson()).toList(),
      'type': type,
      'asOfDate': asOfDate.toIso8601String(),
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ProductInfo copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    String? sku,
    List<ProductCategory>? category,
    String? type,
    DateTime? asOfDate,
    int? reOrderPoint,
    bool? lowStockStatus,
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
      lowStockStatus: lowStockStatus ?? this.lowStockStatus,
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
}
