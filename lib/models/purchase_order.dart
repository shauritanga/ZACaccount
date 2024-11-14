import 'package:uuid/uuid.dart';

class PurchaseOrder {
  String id;
  String permitNo;
  String poStatus;
  DateTime poDate;
  DateTime dueDate;
  String shopId;
  String vendorId;
  String vendorFirstName;
  String vendorLastName;
  String vendorImageUrl;
  String orderId;
  int totalAmount;
  int deposit;
  int balance;
  String paymentMethod;
  String shippingTrackId;
  String notesToVendor;
  String memo;
  List<String> attachments;
  String currencyType;
  DateTime createdAt;
  DateTime updatedAt;

  // Default constructor
  PurchaseOrder({
    String? id,
    this.permitNo = '',
    this.poStatus = '',
    DateTime? poDate,
    DateTime? dueDate,
    this.shopId = '',
    this.vendorId = '',
    this.vendorFirstName = '',
    this.vendorLastName = '',
    this.vendorImageUrl = '',
    this.orderId = '',
    this.totalAmount = 0,
    this.deposit = 0,
    this.balance = 0,
    this.paymentMethod = '',
    this.shippingTrackId = '',
    this.notesToVendor = '',
    this.memo = '',
    List<String>? attachments,
    this.currencyType = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        poDate = poDate ?? DateTime.now(),
        dueDate = dueDate ?? DateTime.now(),
        attachments = attachments ?? [],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'permitNo': permitNo,
      'poStatus': poStatus,
      'poDate': poDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'shopId': shopId,
      'vendorId': vendorId,
      'vendorFirstName': vendorFirstName,
      'vendorLastName': vendorLastName,
      'vendorImageUrl': vendorImageUrl,
      'orderId': orderId,
      'totalAmount': totalAmount,
      'deposit': deposit,
      'balance': balance,
      'paymentMethod': paymentMethod,
      'shippingTrackId': shippingTrackId,
      'notesToVendor': notesToVendor,
      'memo': memo,
      'attachments': attachments,
      'currencyType': currencyType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // JSON deserialization
  factory PurchaseOrder.fromJson(Map<String, dynamic> json) {
    return PurchaseOrder(
      id: json['id'],
      permitNo: json['permitNo'],
      poStatus: json['poStatus'],
      poDate: DateTime.parse(json['poDate']),
      dueDate: DateTime.parse(json['dueDate']),
      shopId: json['shopId'],
      vendorId: json['vendorId'],
      vendorFirstName: json['vendorFirstName'],
      vendorLastName: json['vendorLastName'],
      vendorImageUrl: json['vendorImageUrl'],
      orderId: json['orderId'],
      totalAmount: json['totalAmount'],
      deposit: json['deposit'],
      balance: json['balance'],
      paymentMethod: json['paymentMethod'],
      shippingTrackId: json['shippingTrackId'],
      notesToVendor: json['notesToVendor'],
      memo: json['memo'],
      attachments: List<String>.from(json['attachments']),
      currencyType: json['currencyType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Method to reset to initial values
  void resetToInitialValues() {
    PurchaseOrder();
  }
}
