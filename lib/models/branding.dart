import 'dart:convert';

import 'package:equatable/equatable.dart';

class Branding extends Equatable {
  final String? icon;
  final String? logo;
  final String? primaryColor;
  final String? secondaryColor;
  const Branding({
    this.icon,
    this.logo,
    this.primaryColor,
    this.secondaryColor,
  });

  Branding copyWith({
    String? icon,
    String? logo,
    String? primaryColor,
    String? secondaryColor,
  }) {
    return Branding(
      icon: icon ?? this.icon,
      logo: logo ?? this.logo,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'icon': icon,
      'logo': logo,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
    };
  }

  factory Branding.fromMap(Map<String, dynamic> map) {
    return Branding(
      icon: map['icon'] != null ? map['icon'] as String : null,
      logo: map['logo'] != null ? map['logo'] as String : null,
      primaryColor:
          map['primaryColor'] != null ? map['primaryColor'] as String : null,
      secondaryColor: map['secondaryColor'] != null
          ? map['secondaryColor'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Branding.fromJson(String source) =>
      Branding.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        icon as String,
        logo as String,
        primaryColor as String,
        secondaryColor as String
      ];
}
