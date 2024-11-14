// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DateOfBirth {
  int? day;
  int? month;
  int? year;

  // Constructor
  DateOfBirth({
    this.day,
    this.month,
    this.year,
  });

  DateOfBirth copyWith({
    int? day,
    int? month,
    int? year,
  }) {
    return DateOfBirth(
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'month': month,
      'year': year,
    };
  }

  factory DateOfBirth.fromMap(Map<String, dynamic> map) {
    return DateOfBirth(
      day: map['day'] != null ? map['day'] as int : null,
      month: map['month'] != null ? map['month'] as int : null,
      year: map['year'] != null ? map['year'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DateOfBirth.fromJson(String source) =>
      DateOfBirth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DateOfBirth(day: $day, month: $month, year: $year)';

  @override
  bool operator ==(covariant DateOfBirth other) {
    if (identical(this, other)) return true;

    return other.day == day && other.month == month && other.year == year;
  }

  @override
  int get hashCode => day.hashCode ^ month.hashCode ^ year.hashCode;
}
