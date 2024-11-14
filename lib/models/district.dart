// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class District {
  final String district;
  final String region;
  District({
    required this.district,
    required this.region,
  });

  District copyWith({
    String? district,
    String? region,
  }) {
    return District(
      district: district ?? this.district,
      region: region ?? this.region,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'district': district,
      'region': region,
    };
  }

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      district: map['district'] ?? "",
      region: map['region'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory District.fromJson(String source) =>
      District.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'District(district: $district, region: $region)';

  @override
  bool operator ==(covariant District other) {
    if (identical(this, other)) return true;

    return other.district == district && other.region == region;
  }

  @override
  int get hashCode => district.hashCode ^ region.hashCode;
}
