import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class CurrencyPreference extends Equatable {
  final String id;
  final String currencyCode;
  final String country;

  CurrencyPreference({
    String? id,
    this.currencyCode = "USD",
    this.country = "US Dollar",
  }) : id = id ?? const Uuid().v4();

  factory CurrencyPreference.fromJson(Map<String, dynamic> json) {
    return CurrencyPreference(
      id: json['id'],
      currencyCode: json['currencyCode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currencyCode': currencyCode,
      'country': country,
    };
  }

  @override
  List<Object?> get props => [id, country];
}
