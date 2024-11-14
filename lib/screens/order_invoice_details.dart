import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/models/invoice.dart';
import 'package:zaccount/presentation/providers/invoice_provider.dart';

class OrderInvoiceEditDetails extends ConsumerStatefulWidget {
  const OrderInvoiceEditDetails({super.key, required this.invoice});

  final Invoice invoice;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderInvoiceEditDetailsState();
}

class _OrderInvoiceEditDetailsState
    extends ConsumerState<OrderInvoiceEditDetails> {
  late String invoiceDate;
  late DateTime invoiceDateSubmitted;
  late TextEditingController _invoiceController;

  late String duetDate;
  late DateTime dueDateSubmitted;

  final GlobalKey _popupKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _invoiceTermSelected;
  bool isSaving = false;

  final List<String> paymentMethods = [
    'Custom',
    'Due on receipt',
    'Net 15',
    'Net 30',
    'Net 60'
  ];

  Future<void> _selectInvoiceDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        invoiceDate = DateFormat.yMMMd('en_US').format(picked);
        invoiceDateSubmitted = picked;
      });
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        duetDate = DateFormat.yMMMd('en_US').format(picked);
        dueDateSubmitted = picked;
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
  void initState() {
    super.initState();
    invoiceDate = DateFormat.yMMMd('en_US').format(widget.invoice.invoiceDate);
    invoiceDateSubmitted = widget.invoice.invoiceDate;

    duetDate = DateFormat.yMMMd('en_US').format(widget.invoice.dueDate);
    dueDateSubmitted = widget.invoice.dueDate;

    _invoiceTermSelected = widget.invoice.invoiceTerms;
    _invoiceController = TextEditingController(text: widget.invoice.invoiceNo);
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
                Row(children: [
                  const Text("Invoice No"),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      controller: _invoiceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Invoice Date"),
                    TextButton(
                      onPressed: () {
                        _selectInvoiceDate(context);
                      },
                      child: Text(invoiceDate),
                    )
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Due Date"),
                    TextButton(
                      onPressed: () {
                        _selectDueDate(context);
                      },
                      child: Text(duetDate),
                    )
                  ],
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
                          initialValue: "Invoice Terms",
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
                                  checked: _invoiceTermSelected == item,
                                  child: Text(item),
                                  onTap: () {
                                    setState(() {
                                      _invoiceTermSelected = item;
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
                            Text(_invoiceTermSelected),
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
                ref.read(invoiceProvider.notifier).updateInvoiceDetails(
                    _invoiceTermSelected,
                    dueDateSubmitted,
                    invoiceDateSubmitted,
                    _invoiceController.text);
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
                : const Text("Save Invoice Details"),
          ),
        ),
      ),
    );
  }
}
