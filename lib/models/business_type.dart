enum BusinessTypes {
  individual,
  llc,
  privateCompany,
  publicCompany,
  partnership,
  other,
  empty; // Default case for empty value

  String get description {
    switch (this) {
      case BusinessTypes.individual:
        return 'Individual / Sole Proprietorship';
      case BusinessTypes.llc:
        return 'Limited Liability Company';
      case BusinessTypes.privateCompany:
        return 'Private Company';
      case BusinessTypes.publicCompany:
        return 'Public Company';
      case BusinessTypes.partnership:
        return 'Partnership';
      case BusinessTypes.other:
        return 'Other';
      case BusinessTypes.empty:
        return ''; // Description for the empty value
    }
  }
}
