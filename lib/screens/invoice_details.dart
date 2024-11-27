
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/models/customer.dart';
import 'package:zaccount/models/invoice.dart';
import 'package:zaccount/models/order.dart';
import 'package:zaccount/presentation/providers/invoice_provider.dart';
import 'package:zaccount/screens/invoice_details_edit.dart';
import 'package:zaccount/screens/invoice_preview.dart';

class InvoiceDetails extends ConsumerStatefulWidget {
  const InvoiceDetails({
    required this.invoiceId,
    super.key,
  });
  final String invoiceId;

  @override
  ConsumerState<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends ConsumerState<InvoiceDetails>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool isDateLessOrEqualToNow(DateTime date) {
    DateTime now = DateTime.now();
    return date.isBefore(now) || date.isAtSameMomentAs(now);
  }

  final _key = GlobalKey<ExpandableFabState>();

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceAsync = ref.watch(invoiceAndOrderProvider(widget.invoiceId));

    return invoiceAsync.when(
      data: (data) {
        final invoice = data['invoice'] as Invoice;
        final order = data['order'] as Orders;
        final customer = data['customer'] as Customer;

        final subTotal =
            order.items.fold(0.0, (sum, item) => sum + item.amount);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  decorationColor: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            ),
            title: Text(
              "Invoice No.${invoice.invoiceNo}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            leadingWidth: 100,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.phone_fill,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${order.customerFirstName} ${order.customerLastName}"),
                        Text(
                          invoice.invoiceStatus,
                          style: TextStyle(
                            color: invoice.invoiceStatus == "paid"
                                ? Colors.green
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Total Amount"),
                        Text(
                            "Tsh ${NumberFormat().format(invoice.totalAmount)}"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                isDateLessOrEqualToNow(invoice.dueDate)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            invoice.invoiceStatus == "unpaid"
                                ? "Collect payment"
                                : "Payment collected",
                          ),
                          Transform.scale(
                            scaleY: 0.8,
                            child: TextButton.icon(
                              onPressed: invoice.invoiceStatus == "unpaid"
                                  ? () async {
                                      await FirebaseFirestore.instance
                                          .collection("invoices")
                                          .doc(invoice.id)
                                          .update({'invoiceStatus': "paid"});

                                      setState(() {});
                                    }
                                  : null,
                              label: const Text(""),
                              icon: const Icon(
                                Icons.money,
                                color: Colors.white,
                              ),
                              iconAlignment: IconAlignment.end,
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    invoice.invoiceStatus == "unpaid"
                                        ? Theme.of(context).primaryColor
                                        : Colors.green.shade100,
                              ),
                            ),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Invoice Date"),
                        Text(DateFormat.yMMMd().format(invoice.invoiceDate)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Due Date"),
                        Text(DateFormat.yMMMd().format(invoice.dueDate)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                TabBar(
                  isScrollable: false,
                  controller: _controller,
                  tabs: const [
                    Tab(
                      text: "Details",
                    ),
                    Tab(
                      text: "More Info",
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          const Text("INVOICE ITEMS"),
                          SizedBox(height: 8.h),
                          DataTable(
                            horizontalMargin: 0,
                            columnSpacing: 30,
                            columns: [
                              DataColumn(
                                label: Text(
                                  "Name",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Qty",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Rate",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Unit",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Total",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                            rows: order.items
                                .map(
                                  (item) => DataRow(
                                    cells: [
                                      DataCell(Text(item.item)),
                                      DataCell(Text(item.quantity.toString())),
                                      DataCell(Text(item.rate.toString())),
                                      const DataCell(Text("NA")),
                                      DataCell(
                                        Text(
                                            NumberFormat().format(item.amount)),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Subtotal"),
                              Text(
                                NumberFormat().format(subTotal),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Discount"),
                              Text(
                                NumberFormat().format(order.totalDiscount),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("VAT(18%)"),
                              Text(
                                NumberFormat().format(subTotal * 0.18),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Shipping"),
                              Text(
                                NumberFormat().format(order.shippingCost),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Total"),
                                Text(
                                  NumberFormat().format(invoice.totalAmount),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Deposit"),
                              Text(
                                NumberFormat().format(invoice.deposit),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Invoice balance"),
                                Text(
                                  NumberFormat().format(invoice.balance),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          const Text(
                            "CUSTOMER DETAILS",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.phone_fill,
                                color: Theme.of(context).primaryColor,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                customer.phone,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 9),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.envelope_fill,
                                color: Theme.of(context).primaryColor,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                customer.email,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 9),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.map_fill,
                                color: Theme.of(context).primaryColor,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                customer.phone,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 44.h),
                          const Text(
                            "CUSTOMER NOTE",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            invoice.thanksNote,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: ExpandableFab(
            key: _key,
            distance: 70,
            type: ExpandableFabType.up,
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(Icons.add),
              fabSize: ExpandableFabSize.regular,
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              shape: const CircleBorder(),
              angle: 3.14 * 2,
            ),
            closeButtonBuilder: FloatingActionButtonBuilder(
              size: 56,
              builder: (BuildContext context, void Function()? onPressed,
                  Animation<double> progress) {
                return IconButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Theme.of(context).primaryColor),
                  ),
                  color: Colors.white,
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 40,
                  ),
                );
              },
            ),
            overlayStyle: ExpandableFabOverlayStyle(
              color: Colors.black.withOpacity(0.5),
              blur: 5,
            ),
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                backgroundColor: Theme.of(context).primaryColor,
                shape: const CircleBorder(),
                child: const Icon(
                  CupertinoIcons.alarm_fill,
                  color: Colors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InvoicePreviewScreen(),
                      ));
                  // await sendEmailWithPdf(invoicePdf);
                  //  print("last called");
                },
                backgroundColor: Theme.of(context).primaryColor,
                shape: const CircleBorder(),
                child: const Icon(
                  CupertinoIcons.paperplane_fill,
                  color: Colors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                            "Are you sureyou want to delete this invoice"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              final res = await ref
                                  .read(invoiceProvider.notifier)
                                  .deleteInvoice(invoice.id);
                              if (res) {
                                Navigator.pop(context, true);
                                return;
                              }
                              Navigator.pop(context, false);
                            },
                            child: const Text("Ok"),
                          ),
                        ],
                      );
                    },
                  );
                  Navigator.pop(context);

                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        content: Text("Invoice deleted successfully"),
                      ),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      content: Text("Invoice deleted successfully"),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).primaryColor,
                shape: const CircleBorder(),
                child: const Icon(
                  CupertinoIcons.delete,
                  color: Colors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => EditInvoiceDetails(
                        invoiceId: invoice.id,
                      ),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).primaryColor,
                shape: const CircleBorder(),
                child: const Icon(
                  CupertinoIcons.square_pencil,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text(
            error.toString(),
          ),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
