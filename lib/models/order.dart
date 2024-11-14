// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:zaccount/models/product_item.dart';

class Orders {
  String id;
  int orderNo;
  String status;
  String customerId;
  String customerFirstName;
  String customerLastName;
  String customerImageUrl;
  double shippingCost;
  double totalDiscount;
  double totalAmount;
  List<ProductItem> items;
  String shippingMethod;
  String paymentMethod;
  String invoiceId;
  String shippingTrackId;
  DateTime processingDate;
  String memo;
  DateTime createdAt;
  DateTime updatedAt;

  Orders({
    String? id,
    this.orderNo = 0,
    this.status = "",
    this.customerId = "",
    this.customerFirstName = "",
    this.customerLastName = "",
    this.customerImageUrl = "",
    this.shippingCost = 0,
    this.totalDiscount = 0,
    this.totalAmount = 0,
    List<ProductItem>? items,
    this.shippingMethod = "Pick at store",
    this.paymentMethod = "Cash",
    this.invoiceId = "",
    this.shippingTrackId = "",
    DateTime? processingDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.memo = "",
  })  : id = id ?? const Uuid().v4(),
        items = items ?? [],
        processingDate = processingDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json['id'],
      orderNo: json['orderNo'],
      status: json['status'],
      customerId: json['customerId'],
      customerFirstName: json['customerFirstName'],
      customerLastName: json['customerLastName'],
      customerImageUrl: json['customerImageUrl'],
      shippingCost: json['shippingCost'],
      totalDiscount: json['totalDiscount'],
      totalAmount: json['totalAmount'],
      items: (json['items'] as List<dynamic>)
          .map((item) => ProductItem.fromJson(item))
          .toList(),
      shippingMethod: json['shippingMethod'],
      paymentMethod: json['paymentMethod'],
      invoiceId: json['invoiceId'],
      shippingTrackId: json['shippingTrackId'],
      processingDate: DateTime.parse(json['processingDate']),
      memo: json['memo'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory Orders.fromDocument(DocumentSnapshot json) {
    return Orders(
      id: json.id,
      orderNo: json['orderNo'],
      status: json['status'],
      customerId: json['customerId'],
      customerFirstName: json['customerFirstName'],
      customerLastName: json['customerLastName'],
      customerImageUrl: json['customerImageUrl'],
      shippingCost: json['shippingCost'],
      totalDiscount: json['totalDiscount'],
      totalAmount: json['totalAmount'],
      items: (json['items'] as List<dynamic>)
          .map((item) => ProductItem.fromJson(item))
          .toList(),
      shippingMethod: json['shippingMethod'],
      paymentMethod: json['paymentMethod'],
      invoiceId: json['invoiceId'],
      shippingTrackId: json['shippingTrackId'],
      processingDate: DateTime.parse(json['processingDate']),
      memo: json['memo'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNo': orderNo,
      'status': status,
      'customerId': customerId,
      'customerFirstName': customerFirstName,
      'customerLastName': customerLastName,
      'customerImageUrl': customerImageUrl,
      'shippingCost': shippingCost,
      'totalDiscount': totalDiscount,
      'totalAmount': totalAmount,
      'items': items.map((item) => item.toJson()).toList(),
      'shippingMethod': shippingMethod,
      'paymentMethod': paymentMethod,
      'invoiceId': invoiceId,
      'shippingTrackId': shippingTrackId,
      'processingDate': processingDate.toIso8601String(),
      'memo': memo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Orders copyWith({
    String? id,
    int? orderNo,
    String? status,
    String? customerId,
    String? customerFirstName,
    String? customerLastName,
    String? customerImageUrl,
    double? shippingCost,
    double? totalDiscount,
    double? totalAmount,
    List<ProductItem>? items,
    String? shippingMethod,
    String? paymentMethod,
    String? invoiceId,
    String? shippingTrackId,
    DateTime? processingDate,
    String? memo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Orders(
      id: id ?? this.id,
      orderNo: orderNo ?? this.orderNo,
      status: status ?? this.status,
      customerId: customerId ?? this.customerId,
      customerFirstName: customerFirstName ?? this.customerFirstName,
      customerLastName: customerLastName ?? this.customerLastName,
      customerImageUrl: customerImageUrl ?? this.customerImageUrl,
      shippingCost: shippingCost ?? this.shippingCost,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      totalAmount: totalAmount ?? this.totalAmount,
      items: items ?? this.items,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      invoiceId: invoiceId ?? this.invoiceId,
      shippingTrackId: shippingTrackId ?? this.shippingTrackId,
      processingDate: processingDate ?? this.processingDate,
      memo: memo ?? this.memo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
