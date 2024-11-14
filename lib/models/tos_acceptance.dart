// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TosAcceptance extends Equatable {
  final DateTime? date;
  final String? ip;
  final String? userAgent;
  const TosAcceptance({
    this.date,
    this.ip,
    this.userAgent,
  });

  TosAcceptance copyWith({
    DateTime? date,
    String? ip,
    String? userAgent,
  }) {
    return TosAcceptance(
      date: date ?? this.date,
      ip: ip ?? this.ip,
      userAgent: userAgent ?? this.userAgent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date?.millisecondsSinceEpoch,
      'ip': ip,
      'userAgent': userAgent,
    };
  }

  factory TosAcceptance.fromMap(Map<String, dynamic> map) {
    return TosAcceptance(
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      ip: map['ip'] != null ? map['ip'] as String : null,
      userAgent: map['userAgent'] != null ? map['userAgent'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TosAcceptance.fromJson(String source) =>
      TosAcceptance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props =>
      [date as DateTime, ip as String, userAgent as String];
}
