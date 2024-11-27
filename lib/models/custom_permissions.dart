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

  // Convert to a map for easier handling in the UI
  Map<String, bool> toMap() {
    return {
      'Can Invite Staff': canInviteStaff,
      'Can Manage Inventory': canManageInventory,
      'Can View Reports': canViewReports,
      'Can View Sales Data': canViewSalesData,
      'Can Edit Sales Data': canEditSalesData,
      'Can Create Sales Entries': canCreateSalesEntries,
      'Can Delete Sales Entries': canDeleteSalesEntries,
      'Can Manage Products': canManageProducts,
      'Can Access Financial Reports': canAccessFinancialReports,
      'Can Manage Discounts': canManageDiscounts,
      'Can View Staff Performance': canViewStaffPerformance,
      'Can Edit Store Settings': canEditStoreSettings,
      'Can Generate Reports': canGenerateReports,
      'Can View Customer Data': canViewCustomerData,
      'Can Manage Customer Data': canManageCustomerData,
      'Can Access Analytics': canAccessAnalytics,
      'Can Approve Transactions': canApproveTransactions,
      'Can Manage User Roles': canManageUserRoles,
      'Can Export Data': canExportData,
    };
  }

  // Update from a map
  void updateFromMap(Map<String, bool> map) {
    canInviteStaff = map['Can Invite Staff'] ?? canInviteStaff;
    canManageInventory = map['Can Manage Inventory'] ?? canManageInventory;
    canViewReports = map['Can View Reports'] ?? canViewReports;
    canViewSalesData = map['Can View Sales Data'] ?? canViewSalesData;
    canEditSalesData = map['Can Edit Sales Data'] ?? canEditSalesData;
    canCreateSalesEntries =
        map['Can Create Sales Entries'] ?? canCreateSalesEntries;
    canDeleteSalesEntries =
        map['Can Delete Sales Entries'] ?? canDeleteSalesEntries;
    canManageProducts = map['Can Manage Products'] ?? canManageProducts;
    canAccessFinancialReports =
        map['Can Access Financial Reports'] ?? canAccessFinancialReports;
    canManageDiscounts = map['Can Manage Discounts'] ?? canManageDiscounts;
    canViewStaffPerformance =
        map['Can View Staff Performance'] ?? canViewStaffPerformance;
    canEditStoreSettings =
        map['Can Edit Store Settings'] ?? canEditStoreSettings;
    canGenerateReports = map['Can Generate Reports'] ?? canGenerateReports;
    canViewCustomerData = map['Can View Customer Data'] ?? canViewCustomerData;
    canManageCustomerData =
        map['Can Manage Customer Data'] ?? canManageCustomerData;
    canAccessAnalytics = map['Can Access Analytics'] ?? canAccessAnalytics;
    canApproveTransactions =
        map['Can Approve Transactions'] ?? canApproveTransactions;
    canManageUserRoles = map['Can Manage User Roles'] ?? canManageUserRoles;
    canExportData = map['Can Export Data'] ?? canExportData;
  }
}
