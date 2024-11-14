// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomPermissions {
  bool canInviteStaff = false;
  bool canManageInventory = false;
  bool canViewReports = false;
  bool canViewSalesData = false;
  bool canEditSalesData = false;
  bool canCreateSalesEntries = false;
  bool canDeleteSalesEntries = false;
  bool canManageProducts = false;
  bool canAccessFinancialReports = false;
  bool canManageDiscounts = false;
  bool canViewStaffPerformance = false;
  bool canEditStoreSettings = false;
  bool canGenerateReports = false;
  bool canViewCustomerData = false;
  bool canManageCustomerData = false;
  bool canAccessAnalytics = false;
  bool canApproveTransactions = false;
  bool canManageUserRoles = false;
  bool canExportData = false;
  CustomPermissions({
    required this.canInviteStaff,
    required this.canManageInventory,
    required this.canViewReports,
    required this.canViewSalesData,
    required this.canEditSalesData,
    required this.canCreateSalesEntries,
    required this.canDeleteSalesEntries,
    required this.canManageProducts,
    required this.canAccessFinancialReports,
    required this.canManageDiscounts,
    required this.canViewStaffPerformance,
    required this.canEditStoreSettings,
    required this.canGenerateReports,
    required this.canViewCustomerData,
    required this.canManageCustomerData,
    required this.canAccessAnalytics,
    required this.canApproveTransactions,
    required this.canManageUserRoles,
    required this.canExportData,
  });

  // Method to generate a description string for the object
  static List<String> permissions = [
    'Can Invite Staff',
    "Can Manage Inventory",
    "Can View Reports",
    "Can View Sales Data",
    "Can Edit Sales Data",
    "Can Create Sales Entries",
    "Can Delete Sales Entries",
    "Can Manage Products",
    "Can Access Financial Reports",
    "Can Manage Discounts",
    "Can View Staff Performance",
    "Can Edit Store Settings",
    "Can Generate Reports",
    "Can View Customer Data",
    "Can Manage Customer Data",
    "Can Access Analytics",
    "Can Approve Transactions",
    "Can Manage User Roles",
    "Can Export Data",
  ];
  String get description {
    List<String> permissionList = [];

    if (canInviteStaff) permissionList.add("Invite Staff");
    if (canManageInventory) permissionList.add("Manage Inventory");
    if (canViewReports) permissionList.add("View Reports");
    if (canViewSalesData) permissionList.add("View Sales Data");
    if (canEditSalesData) permissionList.add("Edit Sales Data");
    if (canCreateSalesEntries) permissionList.add("Create Sales Entries");
    if (canDeleteSalesEntries) permissionList.add("Delete Sales Entries");
    if (canManageProducts) permissionList.add("Manage Products");
    if (canAccessFinancialReports) {
      permissionList.add("Access Financial Reports");
    }
    if (canManageDiscounts) permissionList.add("Manage Discounts");
    if (canViewStaffPerformance) permissionList.add("View Staff Performance");
    if (canEditStoreSettings) permissionList.add("Edit Store Settings");
    if (canGenerateReports) permissionList.add("Generate Reports");
    if (canViewCustomerData) permissionList.add("View Customer Data");
    if (canManageCustomerData) permissionList.add("Manage Customer Data");
    if (canAccessAnalytics) permissionList.add("Access Analytics");
    if (canApproveTransactions) permissionList.add("Approve Transactions");
    if (canManageUserRoles) permissionList.add("Manage User Roles");
    if (canExportData) permissionList.add("Export Data");

    return permissionList.join(", ");
  }

  CustomPermissions copyWith({
    bool? canInviteStaff,
    bool? canManageInventory,
    bool? canViewReports,
    bool? canViewSalesData,
    bool? canEditSalesData,
    bool? canCreateSalesEntries,
    bool? canDeleteSalesEntries,
    bool? canManageProducts,
    bool? canAccessFinancialReports,
    bool? canManageDiscounts,
    bool? canViewStaffPerformance,
    bool? canEditStoreSettings,
    bool? canGenerateReports,
    bool? canViewCustomerData,
    bool? canManageCustomerData,
    bool? canAccessAnalytics,
    bool? canApproveTransactions,
    bool? canManageUserRoles,
    bool? canExportData,
  }) {
    return CustomPermissions(
      canInviteStaff: canInviteStaff ?? this.canInviteStaff,
      canManageInventory: canManageInventory ?? this.canManageInventory,
      canViewReports: canViewReports ?? this.canViewReports,
      canViewSalesData: canViewSalesData ?? this.canViewSalesData,
      canEditSalesData: canEditSalesData ?? this.canEditSalesData,
      canCreateSalesEntries: canCreateSalesEntries ?? this.canCreateSalesEntries,
      canDeleteSalesEntries: canDeleteSalesEntries ?? this.canDeleteSalesEntries,
      canManageProducts: canManageProducts ?? this.canManageProducts,
      canAccessFinancialReports: canAccessFinancialReports ?? this.canAccessFinancialReports,
      canManageDiscounts: canManageDiscounts ?? this.canManageDiscounts,
      canViewStaffPerformance: canViewStaffPerformance ?? this.canViewStaffPerformance,
      canEditStoreSettings: canEditStoreSettings ?? this.canEditStoreSettings,
      canGenerateReports: canGenerateReports ?? this.canGenerateReports,
      canViewCustomerData: canViewCustomerData ?? this.canViewCustomerData,
      canManageCustomerData: canManageCustomerData ?? this.canManageCustomerData,
      canAccessAnalytics: canAccessAnalytics ?? this.canAccessAnalytics,
      canApproveTransactions: canApproveTransactions ?? this.canApproveTransactions,
      canManageUserRoles: canManageUserRoles ?? this.canManageUserRoles,
      canExportData: canExportData ?? this.canExportData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'canInviteStaff': canInviteStaff,
      'canManageInventory': canManageInventory,
      'canViewReports': canViewReports,
      'canViewSalesData': canViewSalesData,
      'canEditSalesData': canEditSalesData,
      'canCreateSalesEntries': canCreateSalesEntries,
      'canDeleteSalesEntries': canDeleteSalesEntries,
      'canManageProducts': canManageProducts,
      'canAccessFinancialReports': canAccessFinancialReports,
      'canManageDiscounts': canManageDiscounts,
      'canViewStaffPerformance': canViewStaffPerformance,
      'canEditStoreSettings': canEditStoreSettings,
      'canGenerateReports': canGenerateReports,
      'canViewCustomerData': canViewCustomerData,
      'canManageCustomerData': canManageCustomerData,
      'canAccessAnalytics': canAccessAnalytics,
      'canApproveTransactions': canApproveTransactions,
      'canManageUserRoles': canManageUserRoles,
      'canExportData': canExportData,
    };
  }

  factory CustomPermissions.fromMap(Map<String, dynamic> map) {
    return CustomPermissions(
      canInviteStaff: map['canInviteStaff'] as bool,
      canManageInventory: map['canManageInventory'] as bool,
      canViewReports: map['canViewReports'] as bool,
      canViewSalesData: map['canViewSalesData'] as bool,
      canEditSalesData: map['canEditSalesData'] as bool,
      canCreateSalesEntries: map['canCreateSalesEntries'] as bool,
      canDeleteSalesEntries: map['canDeleteSalesEntries'] as bool,
      canManageProducts: map['canManageProducts'] as bool,
      canAccessFinancialReports: map['canAccessFinancialReports'] as bool,
      canManageDiscounts: map['canManageDiscounts'] as bool,
      canViewStaffPerformance: map['canViewStaffPerformance'] as bool,
      canEditStoreSettings: map['canEditStoreSettings'] as bool,
      canGenerateReports: map['canGenerateReports'] as bool,
      canViewCustomerData: map['canViewCustomerData'] as bool,
      canManageCustomerData: map['canManageCustomerData'] as bool,
      canAccessAnalytics: map['canAccessAnalytics'] as bool,
      canApproveTransactions: map['canApproveTransactions'] as bool,
      canManageUserRoles: map['canManageUserRoles'] as bool,
      canExportData: map['canExportData'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomPermissions.fromJson(String source) => CustomPermissions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomPermissions(canInviteStaff: $canInviteStaff, canManageInventory: $canManageInventory, canViewReports: $canViewReports, canViewSalesData: $canViewSalesData, canEditSalesData: $canEditSalesData, canCreateSalesEntries: $canCreateSalesEntries, canDeleteSalesEntries: $canDeleteSalesEntries, canManageProducts: $canManageProducts, canAccessFinancialReports: $canAccessFinancialReports, canManageDiscounts: $canManageDiscounts, canViewStaffPerformance: $canViewStaffPerformance, canEditStoreSettings: $canEditStoreSettings, canGenerateReports: $canGenerateReports, canViewCustomerData: $canViewCustomerData, canManageCustomerData: $canManageCustomerData, canAccessAnalytics: $canAccessAnalytics, canApproveTransactions: $canApproveTransactions, canManageUserRoles: $canManageUserRoles, canExportData: $canExportData)';
  }

  @override
  bool operator ==(covariant CustomPermissions other) {
    if (identical(this, other)) return true;
  
    return 
      other.canInviteStaff == canInviteStaff &&
      other.canManageInventory == canManageInventory &&
      other.canViewReports == canViewReports &&
      other.canViewSalesData == canViewSalesData &&
      other.canEditSalesData == canEditSalesData &&
      other.canCreateSalesEntries == canCreateSalesEntries &&
      other.canDeleteSalesEntries == canDeleteSalesEntries &&
      other.canManageProducts == canManageProducts &&
      other.canAccessFinancialReports == canAccessFinancialReports &&
      other.canManageDiscounts == canManageDiscounts &&
      other.canViewStaffPerformance == canViewStaffPerformance &&
      other.canEditStoreSettings == canEditStoreSettings &&
      other.canGenerateReports == canGenerateReports &&
      other.canViewCustomerData == canViewCustomerData &&
      other.canManageCustomerData == canManageCustomerData &&
      other.canAccessAnalytics == canAccessAnalytics &&
      other.canApproveTransactions == canApproveTransactions &&
      other.canManageUserRoles == canManageUserRoles &&
      other.canExportData == canExportData;
  }

  @override
  int get hashCode {
    return canInviteStaff.hashCode ^
      canManageInventory.hashCode ^
      canViewReports.hashCode ^
      canViewSalesData.hashCode ^
      canEditSalesData.hashCode ^
      canCreateSalesEntries.hashCode ^
      canDeleteSalesEntries.hashCode ^
      canManageProducts.hashCode ^
      canAccessFinancialReports.hashCode ^
      canManageDiscounts.hashCode ^
      canViewStaffPerformance.hashCode ^
      canEditStoreSettings.hashCode ^
      canGenerateReports.hashCode ^
      canViewCustomerData.hashCode ^
      canManageCustomerData.hashCode ^
      canAccessAnalytics.hashCode ^
      canApproveTransactions.hashCode ^
      canManageUserRoles.hashCode ^
      canExportData.hashCode;
  }
}
