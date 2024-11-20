// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Invoice {
  String id;
  String invoiceNo;
  String invoiceStatus;
  String shopId;
  String customerId;
  String customerFirstName;
  String customerLastName;
  String customerImageUrl;
  String orderId;
  double totalAmount;
  double deposit;
  double balance;
  String invoiceTerms;
  String paymentMethod;
  String shippingTrackId;
  DateTime invoiceDate;
  DateTime dueDate;
  String thanksNote;
  String memo;
  List<String> attachments;
  String currencyType;
  int lateFees;
  bool allowLateFees;
  DateTime createdAt;
  DateTime updatedAt;

  Invoice({
    String? id,
    this.invoiceNo = "1001",
    this.invoiceStatus = "",
    this.shopId = "",
    this.customerId = "",
    this.customerFirstName = "",
    this.customerLastName = "",
    this.customerImageUrl = "",
    this.orderId = "",
    this.totalAmount = 0,
    this.deposit = 0,
    this.balance = 0,
    this.invoiceTerms = "Due on receipt",
    this.paymentMethod = "Cash",
    this.shippingTrackId = "",
    DateTime? invoiceDate,
    DateTime? dueDate,
    this.thanksNote =
        "Thank you for your business. We look forward to serving you again soon!",
    this.memo = "",
    this.attachments = const [],
    this.currencyType = "",
    this.lateFees = 0,
    this.allowLateFees = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        invoiceDate = invoiceDate ?? DateTime.now(),
        dueDate = dueDate ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Invoice.fromJson(String id, Map<String, dynamic> json) {
    return Invoice(
      id: id,
      invoiceNo: json['invoiceNo'],
      invoiceStatus: json['invoiceStatus'],
      shopId: json['shopId'],
      customerId: json['customerId'],
      customerFirstName: json['customerFirstName'],
      customerLastName: json['customerLastName'],
      customerImageUrl: json['customerImageUrl'],
      orderId: json['orderId'],
      totalAmount: json['totalAmount'],
      deposit: json['deposit'],
      balance: json['balance'],
      invoiceTerms: json['invoiceTerms'],
      paymentMethod: json['paymentMethod'],
      shippingTrackId: json['shippingTrackId'],
      invoiceDate: DateTime.parse(json['invoiceDate']),
      dueDate: DateTime.parse(json['dueDate']),
      thanksNote: json['thanksNote'],
      memo: json['memo'],
      attachments: List<String>.from(json['attachments']),
      currencyType: json['currencyType'],
      lateFees: json['lateFees'],
      allowLateFees: json['allowLateFees'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  factory Invoice.fromDocument(DocumentSnapshot json) {
    return Invoice(
      id: json.id,
      invoiceNo: json['invoiceNo'],
      invoiceStatus: json['invoiceStatus'],
      shopId: json['shopId'],
      customerId: json['customerId'],
      customerFirstName: json['customerFirstName'],
      customerLastName: json['customerLastName'],
      customerImageUrl: json['customerImageUrl'],
      orderId: json['orderId'],
      totalAmount: json['totalAmount'],
      deposit: json['deposit'],
      balance: json['balance'],
      invoiceTerms: json['invoiceTerms'],
      paymentMethod: json['paymentMethod'],
      shippingTrackId: json['shippingTrackId'],
      invoiceDate: DateTime.parse(json['invoiceDate']),
      dueDate: DateTime.parse(json['dueDate']),
      thanksNote: json['thanksNote'],
      memo: json['memo'],
      attachments: List<String>.from(json['attachments']),
      currencyType: json['currencyType'],
      lateFees: json['lateFees'],
      allowLateFees: json['allowLateFees'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceNo': invoiceNo,
      'invoiceStatus': invoiceStatus,
      'shopId': shopId,
      'customerId': customerId,
      'customerFirstName': customerFirstName,
      'customerLastName': customerLastName,
      'customerImageUrl': customerImageUrl,
      'orderId': orderId,
      'totalAmount': totalAmount,
      'deposit': deposit,
      'balance': balance,
      'invoiceTerms': invoiceTerms,
      'paymentMethod': paymentMethod,
      'shippingTrackId': shippingTrackId,
      'invoiceDate': invoiceDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'thanksNote': thanksNote,
      'memo': memo,
      'attachments': attachments,
      'currencyType': currencyType,
      'lateFees': lateFees,
      'allowLateFees': allowLateFees,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Invoice copyWith({
    String? id,
    String? invoiceNo,
    String? invoiceStatus,
    String? shopId,
    String? customerId,
    String? customerFirstName,
    String? customerLastName,
    String? customerImageUrl,
    String? orderId,
    double? totalAmount,
    double? deposit,
    double? balance,
    String? invoiceTerms,
    String? paymentMethod,
    String? shippingTrackId,
    DateTime? invoiceDate,
    DateTime? dueDate,
    String? thanksNote,
    String? memo,
    List<String>? attachments,
    String? currencyType,
    int? lateFees,
    bool? allowLateFees,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Invoice(
      id: id ?? this.id,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      invoiceStatus: invoiceStatus ?? this.invoiceStatus,
      shopId: shopId ?? this.shopId,
      customerId: customerId ?? this.customerId,
      customerFirstName: customerFirstName ?? this.customerFirstName,
      customerLastName: customerLastName ?? this.customerLastName,
      customerImageUrl: customerImageUrl ?? this.customerImageUrl,
      orderId: orderId ?? this.orderId,
      totalAmount: totalAmount ?? this.totalAmount,
      deposit: deposit ?? this.deposit,
      balance: balance ?? this.balance,
      invoiceTerms: invoiceTerms ?? this.invoiceTerms,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shippingTrackId: shippingTrackId ?? this.shippingTrackId,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      dueDate: dueDate ?? this.dueDate,
      thanksNote: thanksNote ?? this.thanksNote,
      memo: memo ?? this.memo,
      attachments: attachments ?? this.attachments,
      currencyType: currencyType ?? this.currencyType,
      lateFees: lateFees ?? this.lateFees,
      allowLateFees: allowLateFees ?? this.allowLateFees,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
