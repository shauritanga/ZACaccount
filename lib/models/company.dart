// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'package:zaccount/models/branding.dart';
import 'package:zaccount/models/business_profile.dart';
import 'package:zaccount/models/company_profile.dart';
import 'package:zaccount/models/individual.dart';
import 'package:zaccount/models/owner.dart';
import 'package:zaccount/models/representative.dart';
import 'package:zaccount/models/staff.dart';
import 'package:zaccount/models/tos_acceptance.dart';

class Company extends Equatable {
  final String id;
  final BusinessProfile? businessProfile;
  final String? businessType;
  final CompanyProfile? companyProfile;
  final Individual? individual;
  final List<Owner>? owners;
  final List<Representative>? representatives;
  final List<StaffDetails>? staffs;
  final List<String>? staffIds;
  final bool? chargeEnabled;
  final String? country;
  final String? defaultCurrency;
  final bool? detailsSubmitted;
  final String? email;
  final bool? payoutEnabled;
  final Branding? branding;
  final TosAcceptance? tosAcceptance;
  final String? displayName;
  final String? timezone;
  final DateTime created;
  final DateTime updated;
  Company({
    String? id,
    this.businessProfile,
    this.businessType,
    this.companyProfile,
    this.individual,
    this.owners,
    this.representatives,
    this.staffs,
    this.staffIds,
    this.chargeEnabled,
    this.country,
    this.defaultCurrency,
    this.detailsSubmitted,
    this.email,
    this.payoutEnabled,
    this.branding,
    this.tosAcceptance,
    this.displayName,
    this.timezone,
    required this.created,
    required this.updated,
  }) : id = id ?? const Uuid().v4();

  Company copyWith({
    String? id,
    BusinessProfile? businessProfile,
    String? businessType,
    CompanyProfile? companyProfile,
    Individual? individual,
    List<Owner>? owners,
    List<Representative>? representatives,
    List<StaffDetails>? staffs,
    List<String>? staffIds,
    bool? chargeEnabled,
    String? country,
    String? defaultCurrency,
    bool? detailsSubmitted,
    String? email,
    bool? payoutEnabled,
    Branding? branding,
    TosAcceptance? tosAcceptance,
    String? displayName,
    String? timezone,
    DateTime? created,
    DateTime? updated,
  }) {
    return Company(
      id: id ?? this.id,
      businessProfile: businessProfile ?? this.businessProfile,
      businessType: businessType ?? this.businessType,
      companyProfile: companyProfile ?? this.companyProfile,
      individual: individual ?? this.individual,
      owners: owners ?? this.owners,
      representatives: representatives ?? this.representatives,
      staffs: staffs ?? this.staffs,
      staffIds: staffIds ?? this.staffIds,
      chargeEnabled: chargeEnabled ?? this.chargeEnabled,
      country: country ?? this.country,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      detailsSubmitted: detailsSubmitted ?? this.detailsSubmitted,
      email: email ?? this.email,
      payoutEnabled: payoutEnabled ?? this.payoutEnabled,
      branding: branding ?? this.branding,
      tosAcceptance: tosAcceptance ?? this.tosAcceptance,
      displayName: displayName ?? this.displayName,
      timezone: timezone ?? this.timezone,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'businessProfile': businessProfile?.toMap(),
      'businessType': businessType,
      'companyProfile': companyProfile?.toMap(),
      'individual': individual?.toMap(),
      'owners': owners?.map((x) => x.toMap()).toList(),
      'representatives': representatives?.map((x) => x.toMap()).toList(),
      'staffs': staffs?.map((x) => x.toMap()).toList(),
      'staffIds': staffIds,
      'chargeEnabled': chargeEnabled,
      'country': country,
      'defaultCurrency': defaultCurrency,
      'detailsSubmitted': detailsSubmitted,
      'email': email,
      'payoutEnabled': payoutEnabled,
      'branding': branding?.toMap(),
      'tosAcceptance': tosAcceptance?.toMap(),
      'displayName': displayName,
      'timezone': timezone,
      'created': created.millisecondsSinceEpoch,
      'updated': updated.millisecondsSinceEpoch,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] ?? "",
      businessProfile: map['businessProfile'] != null
          ? BusinessProfile.fromMap(
              map['businessProfile'] as Map<String, dynamic>)
          : null,
      businessType:
          map['businessType'] != null ? map['businessType'] as String : null,
      companyProfile: map['companyProfile'] != null
          ? CompanyProfile.fromMap(
              map['companyProfile'] as Map<String, dynamic>)
          : null,
      individual: map['individual'] != null
          ? Individual.fromMap(map['individual'] as Map<String, dynamic>)
          : null,
      owners: map['owners'] != null
          ? List<Owner>.from(
              (map['owners'] as List<int>).map<Owner?>(
                (x) => Owner.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      representatives: map['representatives'] != null
          ? List<Representative>.from(
              (map['representatives'] as List<int>).map<Representative?>(
                (x) => Representative.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      staffs: map['staffs'] != null
          ? List<StaffDetails>.from(
              (map['staffs'] as List<int>).map<StaffDetails?>(
                (x) => StaffDetails.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      staffIds: map['staffIds'] != null
          ? List<String>.from((map['staffIds'] as List<String>))
          : null,
      chargeEnabled:
          map['chargeEnabled'] != null ? map['chargeEnabled'] as bool : null,
      country: map['country'] != null ? map['country'] as String : null,
      defaultCurrency: map['defaultCurrency'] != null
          ? map['defaultCurrency'] as String
          : null,
      detailsSubmitted: map['detailsSubmitted'] != null
          ? map['detailsSubmitted'] as bool
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      payoutEnabled:
          map['payoutEnabled'] != null ? map['payoutEnabled'] as bool : null,
      branding: map['branding'] != null
          ? Branding.fromMap(map['branding'] as Map<String, dynamic>)
          : null,
      tosAcceptance: map['tosAcceptance'] != null
          ? TosAcceptance.fromMap(map['tosAcceptance'] as Map<String, dynamic>)
          : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      timezone: map['timezone'] != null ? map['timezone'] as String : null,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      country as String,
      email as String,
    ];
  }
}
