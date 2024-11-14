import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/presentation/providers/expense_provider.dart';
import 'package:zaccount/utils/constants.dart';

class ExpensePaymentDetailsForm extends ConsumerStatefulWidget {
  const ExpensePaymentDetailsForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExpensePaymentDetailsFormState();
}

class _ExpensePaymentDetailsFormState
    extends ConsumerState<ExpensePaymentDetailsForm> {
  String paymentDate = DateFormat.yMMMMd('en_US').format(DateTime.now());
  DateTime paymentDateSubmitted = DateTime.now();
  final GlobalKey _popupKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _paymentMethodSelected = "Select Payment";
  String referenceNumber = "";
  String permitNumber = "";
  String note = "";
  bool isSaving = false;

  final List<String> paymentMethods = [
    'Cash',
    'Apple Pay',
    'Visa',
    'MasterCard',
    'PayPal'
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        paymentDate = DateFormat.yMMMMd('en_US').format(picked);
        paymentDateSubmitted = picked;
      });
    }
  }

  Offset _getButtonPosition() {
    // Get the RenderBox of the button
    final RenderBox renderBox =
        _popupKey.currentContext?.findRenderObject() as RenderBox;

    // Get the position of the button on the screen
    final Offset position = renderBox.localToGlobal(Offset.zero);

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: primary,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
        title: Text(
          "Payment Details",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leadingWidth: 100.w,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Payment Date"),
                    TextButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(paymentDate),
                    )
                  ],
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Reference no"),
                  onSaved: (value) => referenceNumber = value!,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Permit no"),
                  onSaved: (value) => permitNumber = value!,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Payment Method"),
                    GestureDetector(
                      onTap: () {
                        final position = _getButtonPosition();
                        showMenu(
                          initialValue: "Select Payment",
                          color: Colors.white,
                          context: context,
                          position: RelativeRect.fromLTRB(
                            position.dx,
                            position.dy + 50,
                            MediaQuery.sizeOf(context).width - position.dx,
                            0,
                          ),
                          items: paymentMethods
                              .map<PopupMenuEntry>(
                                (item) => CheckedPopupMenuItem(
                                  value: item,
                                  checked: _paymentMethodSelected == item,
                                  child: Text(item),
                                  onTap: () {
                                    setState(() {
                                      _paymentMethodSelected = item;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        height: 48,
                        key: _popupKey,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Text(_paymentMethodSelected),
                            SizedBox(width: 4.w),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.chevron_up_chevron_down),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                const Text("Memo"),
                SizedBox(height: 8.h),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  maxLines: 3,
                  onSaved: (value) => note = value!,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState?.save();

                ref.read(expenseProvider.notifier).updatePaymentDetails(
                    note: note,
                    reference: referenceNumber,
                    permit: permitNumber,
                    paymentDate: paymentDateSubmitted,
                    paymentMethod: _paymentMethodSelected);
              }
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor,
              ),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            child: isSaving
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text("Add Expense"),
          ),
        ),
      ),
    );
  }
}
