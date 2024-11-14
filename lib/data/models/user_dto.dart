// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDto {
  final String? firstName;
  final String? lastName;
  final String? emalAddress;
  final String? dob;
  final String? role;
  final String? department;
  final String? phone;
  final String? gender;
  final String? streetAddress;
  final String? aptNumber;

  UserDto({
    this.firstName,
    this.lastName,
    this.emalAddress,
    this.dob,
    this.role,
    this.department,
    this.phone,
    this.gender,
    this.streetAddress,
    this.aptNumber,
  });

  double filledFieldsPercentage() {
    // Get a list of all fields
    List fields = [
      firstName,
      lastName,
      emalAddress,
      dob,
      role,
      department,
      phone,
      gender,
      streetAddress,
      aptNumber
    ];

    // Count non-null, non-empty fields
    int filledFields = fields
        .where((field) => field != null && field.toString().isNotEmpty)
        .length;

    // Calculate the percentage
    return (filledFields / fields.length) * 16;
  }

  UserDto copyWith({
    String? firstName,
    String? lastName,
    String? emalAddress,
    String? dob,
    String? role,
    String? department,
    String? phone,
    String? gender,
    String? streetAddress,
    String? aptNumber,
  }) {
    return UserDto(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      emalAddress: emalAddress ?? this.emalAddress,
      dob: dob ?? this.dob,
      role: role ?? this.role,
      department: department ?? this.department,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      streetAddress: streetAddress ?? this.streetAddress,
      aptNumber: aptNumber ?? this.aptNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'emalAddress': emalAddress,
      'dob': dob,
      'role': role,
      'department': department,
      'phone': phone,
      'gender': gender,
      'streetAddress': streetAddress,
      'aptNumber': aptNumber,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      emalAddress:
          map['emalAddress'] != null ? map['emalAddress'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      department:
          map['department'] != null ? map['department'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      streetAddress:
          map['streetAddress'] != null ? map['streetAddress'] as String : null,
      aptNumber: map['aptNumber'] != null ? map['aptNumber'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDto(firstName: $firstName, lastName: $lastName, emalAddress: $emalAddress, dob: $dob, role: $role, department: $department, phone: $phone, gender: $gender, streetAddress: $streetAddress, aptNumber: $aptNumber)';
  }

  @override
  bool operator ==(covariant UserDto other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.emalAddress == emalAddress &&
        other.dob == dob &&
        other.role == role &&
        other.department == department &&
        other.phone == phone &&
        other.gender == gender &&
        other.streetAddress == streetAddress &&
        other.aptNumber == aptNumber;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        emalAddress.hashCode ^
        dob.hashCode ^
        role.hashCode ^
        department.hashCode ^
        phone.hashCode ^
        gender.hashCode ^
        streetAddress.hashCode ^
        aptNumber.hashCode;
  }
}
