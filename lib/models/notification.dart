import 'package:uuid/uuid.dart';

class NotificationOptions {
  String id;
  bool invoiceDueDateReminderEnabled;
  bool invoiceStatusUpdateEnabled;
  bool paymentConfirmationEnabled;
  bool paymentReminderEnabled;
  bool lateFeeNotificationEnabled;
  bool expenseOverdueReminderEnabled;
  bool purchaseOrderStatusUpdateEnabled;
  bool communicationReminderEnabled;
  bool productLowStockAlertEnabled;
  bool financialSummaryAlertsEnabled;

  // Additional notification options
  bool accountActivityAlertsEnabled;
  bool taskRemindersEnabled;
  bool documentUploadAlertsEnabled;
  bool feedbackRequestsEnabled;
  bool subscriptionRenewalNoticesEnabled;
  bool errorAlertsEnabled;
  bool customizableNotificationsEnabled;

  NotificationOptions({
    String? id,
    this.invoiceDueDateReminderEnabled = true,
    this.invoiceStatusUpdateEnabled = true,
    this.paymentConfirmationEnabled = true,
    this.paymentReminderEnabled = true,
    this.lateFeeNotificationEnabled = true,
    this.expenseOverdueReminderEnabled = true,
    this.purchaseOrderStatusUpdateEnabled = true,
    this.communicationReminderEnabled = true,
    this.productLowStockAlertEnabled = true,
    this.financialSummaryAlertsEnabled = true,
    this.accountActivityAlertsEnabled = true,
    this.taskRemindersEnabled = true,
    this.documentUploadAlertsEnabled = true,
    this.feedbackRequestsEnabled = true,
    this.subscriptionRenewalNoticesEnabled = true,
    this.errorAlertsEnabled = true,
    this.customizableNotificationsEnabled = true,
  }) : id = id ?? const Uuid().v4();

  factory NotificationOptions.fromJson(Map<String, dynamic> json) {
    return NotificationOptions(
      id: json['id'],
      invoiceDueDateReminderEnabled: json['invoiceDueDateReminderEnabled'],
      invoiceStatusUpdateEnabled: json['invoiceStatusUpdateEnabled'],
      paymentConfirmationEnabled: json['paymentConfirmationEnabled'],
      paymentReminderEnabled: json['paymentReminderEnabled'],
      lateFeeNotificationEnabled: json['lateFeeNotificationEnabled'],
      expenseOverdueReminderEnabled: json['expenseOverdueReminderEnabled'],
      purchaseOrderStatusUpdateEnabled:
          json['purchaseOrderStatusUpdateEnabled'],
      communicationReminderEnabled: json['communicationReminderEnabled'],
      productLowStockAlertEnabled: json['productLowStockAlertEnabled'],
      financialSummaryAlertsEnabled: json['financialSummaryAlertsEnabled'],
      accountActivityAlertsEnabled: json['accountActivityAlertsEnabled'],
      taskRemindersEnabled: json['taskRemindersEnabled'],
      documentUploadAlertsEnabled: json['documentUploadAlertsEnabled'],
      feedbackRequestsEnabled: json['feedbackRequestsEnabled'],
      subscriptionRenewalNoticesEnabled:
          json['subscriptionRenewalNoticesEnabled'],
      errorAlertsEnabled: json['errorAlertsEnabled'],
      customizableNotificationsEnabled:
          json['customizableNotificationsEnabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceDueDateReminderEnabled': invoiceDueDateReminderEnabled,
      'invoiceStatusUpdateEnabled': invoiceStatusUpdateEnabled,
      'paymentConfirmationEnabled': paymentConfirmationEnabled,
      'paymentReminderEnabled': paymentReminderEnabled,
      'lateFeeNotificationEnabled': lateFeeNotificationEnabled,
      'expenseOverdueReminderEnabled': expenseOverdueReminderEnabled,
      'purchaseOrderStatusUpdateEnabled': purchaseOrderStatusUpdateEnabled,
      'communicationReminderEnabled': communicationReminderEnabled,
      'productLowStockAlertEnabled': productLowStockAlertEnabled,
      'financialSummaryAlertsEnabled': financialSummaryAlertsEnabled,
      'accountActivityAlertsEnabled': accountActivityAlertsEnabled,
      'taskRemindersEnabled': taskRemindersEnabled,
      'documentUploadAlertsEnabled': documentUploadAlertsEnabled,
      'feedbackRequestsEnabled': feedbackRequestsEnabled,
      'subscriptionRenewalNoticesEnabled': subscriptionRenewalNoticesEnabled,
      'errorAlertsEnabled': errorAlertsEnabled,
      'customizableNotificationsEnabled': customizableNotificationsEnabled,
    };
  }
}
