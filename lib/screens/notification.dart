import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late double _deviceWidth, _deviceHeight;
  bool _invoiceDueDateRemainder = false;
  bool _invoiceStatusUpdate = false;
  bool _invoicePaymentConfirmation = false;
  bool _invoicePaymentRemainder = false;
  bool _invoiceLatefeeNotification = false;
  bool _expenseOverDue = false;
  bool _purcchaseOrderUpdate = false;
  bool _accountActivityAlert = false;
  bool _taskRemainer = false;
  bool _documentUpload = false;
  bool _feedbackRequest = false;
  bool _subscriptionRenew = false;
  bool _errorAlert = false;
  bool _financialSummaryAlert = false;
  bool _productAlert = false;
  bool _communicationRemainder = false;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.01),
                  child: Text(
                    "INVOICE",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.015),
                  width: _deviceWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        value: _invoiceDueDateRemainder,
                        title: "Invoice Due Date Remainder",
                        subTitle:
                            "Get notified when an invoice's due date is approaching",
                        onChanged: (value) {
                          setState(() {
                            _invoiceDueDateRemainder = value;
                          });
                        },
                      ),
                      const Divider(),
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        value: _invoiceStatusUpdate,
                        title: "Invoice Status Updates",
                        subTitle:
                            "Get notified whenever there is a change in the status of your invoice.",
                        onChanged: (value) {
                          setState(() {
                            _invoiceStatusUpdate = value;
                          });
                        },
                      ),
                      const Divider(),
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        value: _invoicePaymentConfirmation,
                        title: "Payment Confirmation",
                        subTitle:
                            "Get notified whenever a payment is confirmed",
                        onChanged: (value) {
                          setState(() {
                            _invoicePaymentConfirmation = value;
                          });
                        },
                      ),
                      const Divider(),
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        value: _invoicePaymentRemainder,
                        title: "Payment Remainder",
                        subTitle: "Get reminded when payments are due.",
                        onChanged: (value) {
                          setState(() {
                            _invoicePaymentRemainder = value;
                          });
                        },
                      ),
                      const Divider(),
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        value: _invoiceLatefeeNotification,
                        title: "Late Fee Notification",
                        subTitle:
                            "Get notified when late fees are applied to an invoice.",
                        onChanged: (value) {
                          setState(() {
                            _invoiceLatefeeNotification = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _deviceHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.01),
                  child: Text(
                    "EXPENSE",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.015),
                  width: _deviceWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomSwitch(
                    deviceWidth: _deviceWidth,
                    onChanged: (value) {
                      setState(() {
                        _expenseOverDue = value;
                      });
                    },
                    value: _expenseOverDue,
                    title: "Expense Overdue Remainder",
                    subTitle: "Get remainded when expenses are overdue.",
                  ),
                ),
                SizedBox(height: _deviceHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.01),
                  child: Text(
                    "PURCHASE ORDER",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.015),
                  width: _deviceWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomSwitch(
                      deviceWidth: _deviceWidth,
                      onChanged: (value) {
                        setState(() {
                          _purcchaseOrderUpdate = value;
                        });
                      },
                      value: _purcchaseOrderUpdate,
                      title: "Purchase Order Status Update",
                      subTitle:
                          "Get notified when there's an update on a purchase order."),
                ),
                SizedBox(height: _deviceHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.01),
                  child: Text(
                    "CUSTOMER?VENDOR",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.015),
                  width: _deviceWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomSwitch(
                    deviceWidth: _deviceWidth,
                    onChanged: (value) {
                      setState(() {
                        _communicationRemainder = value;
                      });
                    },
                    value: _communicationRemainder,
                    title: "Communication Remainder",
                    subTitle:
                        "Get remainded about communication with customers/vendors.",
                  ),
                ),
                SizedBox(height: _deviceHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.01),
                  child: Text(
                    "PRODUCT",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.015),
                  width: _deviceWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomSwitch(
                    deviceWidth: _deviceWidth,
                    onChanged: (value) {
                      setState(() {
                        _productAlert = value;
                      });
                    },
                    value: _productAlert,
                    title: "Product Low Stock Alerts",
                    subTitle:
                        "Get notifiedwhen a product is running low on stock.",
                  ),
                ),
                SizedBox(height: _deviceHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.01),
                  child: Text(
                    "REPORTS",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.015),
                  width: _deviceWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomSwitch(
                    deviceWidth: _deviceWidth,
                    onChanged: (value) {
                      setState(() {
                        _financialSummaryAlert = value;
                      });
                    },
                    value: _financialSummaryAlert,
                    title: "Financial Summary Alerts",
                    subTitle: "Get notified about final summary updates.",
                  ),
                ),
                SizedBox(height: _deviceHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.01),
                  child: Text(
                    "ADITIONAL NOTIFICATIONS",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.04,
                      vertical: _deviceHeight * 0.015),
                  width: _deviceWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        onChanged: (value) {
                          setState(() {
                            _accountActivityAlert = value;
                          });
                        },
                        value: _accountActivityAlert,
                        title: "Account Activity Alerts",
                        subTitle:
                            "Get notified about significant changes or activities related to your account.",
                      ),
                      const Divider(),
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        onChanged: (value) {
                          setState(() {
                            _taskRemainer = value;
                          });
                        },
                        value: _taskRemainer,
                        title: "Task Remainders",
                        subTitle:
                            "Get remainders for upcoming tasks or deadlinesount.",
                      ),
                      const Divider(),
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        onChanged: (value) {
                          setState(() {
                            _documentUpload = value;
                          });
                        },
                        value: _documentUpload,
                        title: "Document Upload Alerts",
                        subTitle:
                            "Get notified when documents or files are uploaded or shared.",
                      ),
                      const Divider(),
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        onChanged: (value) {
                          setState(() {
                            _feedbackRequest = value;
                          });
                        },
                        value: _feedbackRequest,
                        title: "Feedback Requests",
                        subTitle:
                            "Get notified to provide feedback or reviews about the application",
                      ),
                      const Divider(),
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        onChanged: (value) {
                          setState(() {
                            _subscriptionRenew = value;
                          });
                        },
                        value: _subscriptionRenew,
                        title: "Subscription Renewal Notices",
                        subTitle:
                            "Get notified about upcoming subscription reneewal or changes.",
                      ),
                      const Divider(),
                      CustomSwitch(
                        deviceWidth: _deviceWidth,
                        onChanged: (value) {
                          setState(() {
                            _errorAlert = value;
                          });
                        },
                        value: _errorAlert,
                        title: "Error Alerts",
                        subTitle:
                            "Get notified about critical errors or exceptions within the application.",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _deviceHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required double deviceWidth,
    required this.onChanged,
    required this.value,
    required this.title,
    required this.subTitle,
  }) : _deviceWidth = deviceWidth;

  final double _deviceWidth;
  final bool value;
  final String title;
  final String subTitle;

  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                subTitle,
                style: GoogleFonts.roboto(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(width: _deviceWidth * 0.07),
            Switch(
              value: value,
              onChanged: onChanged,
              thumbColor: const WidgetStatePropertyAll<Color>(Colors.white),
              activeTrackColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
