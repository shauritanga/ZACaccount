import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaccount/models/order_invoice.dart';
import 'package:zaccount/presentation/providers/invoice_provider.dart';
import 'package:zaccount/presentation/providers/order_provider.dart';

class OrderInvoiceAdditionalEditDetails extends ConsumerStatefulWidget {
  const OrderInvoiceAdditionalEditDetails({super.key, required this.invoice});

  final OrderInvoice invoice;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderInvoiceAdditionalEditDetailsState();
}

class _OrderInvoiceAdditionalEditDetailsState
    extends ConsumerState<OrderInvoiceAdditionalEditDetails> {
  late String invoiceDate;
  late DateTime invoiceDateSubmitted;

  late String duetDate;
  late DateTime dueDateSubmitted;

  late TextEditingController _thankController;
  late TextEditingController _memoController;
  late TextEditingController _latefees;

  final GlobalKey _popupKey = GlobalKey();
  final GlobalKey _popupKey2 = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _invoicePaymentSelected;
  late String _invoiceShippingSelected;
  bool isSaving = false;
  bool _allowLateFees = false;

  final List<String> paymentMethods = [
    'Cash',
    'Apple Pay',
    'Visa',
    'MasterCard',
    'PayPal'
  ];
  final List<String> pickingMethods = [
    'Pick at store',
    'Standart Rate',
    'Express Rate',
    'Overnight',
  ];

  Offset _getButtonPosition() {
    // Get the RenderBox of the button
    final RenderBox renderBox =
        _popupKey.currentContext?.findRenderObject() as RenderBox;

    // Get the position of the button on the screen
    final Offset position = renderBox.localToGlobal(Offset.zero);

    return position;
  }

  @override
  void initState() {
    super.initState();
    _thankController = TextEditingController(text: widget.invoice.customerNote);
    _memoController = TextEditingController(text: widget.invoice.memo);
    _latefees = TextEditingController(text: widget.invoice.lateFees.toString());
    _invoicePaymentSelected = widget.invoice.paymentMethod;
    _invoiceShippingSelected = widget.invoice.shippingMethod;
  }

  @override
  void dispose() {
    super.dispose();
    _thankController.dispose();
    _memoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Container(),
        title: Text(
          "Invoice Details",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leadingWidth: 100.w,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
        ],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Payment Method"),
                    GestureDetector(
                      onTap: () {
                        final position = _getButtonPosition();
                        showMenu(
                          initialValue: "Invoice Terms",
                          color: Colors.white,
                          context: context,
                          position: RelativeRect.fromLTRB(
                            position.dx,
                            position.dy + 50,
                            position.dx,
                            0,
                          ),
                          items: paymentMethods
                              .map<PopupMenuEntry>(
                                (item) => CheckedPopupMenuItem(
                                  value: item,
                                  checked: _invoicePaymentSelected == item,
                                  child: Text(item),
                                  onTap: () {
                                    setState(() {
                                      _invoicePaymentSelected = item;
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
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _invoicePaymentSelected,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              CupertinoIcons.chevron_up_chevron_down,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Shipping Method"),
                    GestureDetector(
                      onTap: () {
                        final position = _getButtonPosition();
                        showMenu(
                          initialValue: "Invoice Terms",
                          color: Colors.white,
                          context: context,
                          position: RelativeRect.fromLTRB(
                            position.dx,
                            position.dy + 50,
                            position.dx,
                            0,
                          ),
                          items: pickingMethods
                              .map<PopupMenuEntry>(
                                (item) => CheckedPopupMenuItem(
                                  value: item,
                                  checked: _invoiceShippingSelected == item,
                                  child: Text(item),
                                  onTap: () {
                                    setState(() {
                                      _invoiceShippingSelected = item;
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
                        key: _popupKey2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _invoiceShippingSelected,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              CupertinoIcons.chevron_up_chevron_down,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Text("Customer notes"),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _thankController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 24.h),
                const Text("Memo(Hiden from invoice)"),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _memoController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 24.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Allow Late Fees"),
                  trailing: Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: _allowLateFees,
                      onChanged: (value) {
                        setState(() {
                          _allowLateFees = value;
                        });
                      },
                    ),
                  ),
                ),
                _allowLateFees
                    ? TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.history,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      )
                    : Container(),
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
              ref.read(invoiceProvider.notifier).updateAdditionDetails(
                    _invoicePaymentSelected,
                    _thankController.text,
                    _memoController.text,
                    int.parse(_latefees.text),
                  );
              ref
                  .read(orderProvider.notifier)
                  .updateShippingMethod(_invoiceShippingSelected);

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
                : const Text("Save Invoice Details"),
          ),
        ),
      ),
    );
  }
}
