import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/models/customer.dart';
import 'package:zaccount/models/invoice.dart';
import 'package:zaccount/models/order.dart';
import 'package:zaccount/presentation/providers/invoice_provider.dart';

class EditInvoiceDetails extends ConsumerStatefulWidget {
  const EditInvoiceDetails({
    required this.invoiceId,
    super.key,
  });
  final String invoiceId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditInvoiceDetailsState();
}

class _EditInvoiceDetailsState extends ConsumerState<EditInvoiceDetails> {
  bool isSaving = false;
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
              "Invoice ${invoice.invoiceNo}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            leadingWidth: 100,
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    decorationColor: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Text("CUSTOMER DETAILS"),
                ),
                SizedBox(height: 16.h),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.firstName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(customer.email),
                      SizedBox(height: 8.h),
                      Text(
                          "${customer.shippingAddress?.street}, ${customer.shippingAddress?.unitNumber}"),
                      SizedBox(height: 8.h),
                      Text(
                          "${customer.shippingAddress?.city}, ${customer.shippingAddress?.country}"),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Text("INVOICE ITEMS"),
                ),
                SizedBox(height: 18.h),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: order.items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = order.items[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.item,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "TZS ${NumberFormat().format(item.amount)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text("SKU: ${item.sku}"),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Text(
                                "quantity ${item.quantity}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text(
                                "Item Price TZS ${NumberFormat().format(item.rate)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          index == 2
                              ? TextButton.icon(
                                  style: const ButtonStyle(
                                    padding:
                                        WidgetStatePropertyAll(EdgeInsets.zero),
                                  ),
                                  onPressed: () {},
                                  label: const Text("Add Product"),
                                  icon: Icon(
                                    CupertinoIcons.add_circled_solid,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : Container(),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 32.h),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal"),
                          Text(
                            "TZS ${NumberFormat().format(subTotal)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("VAT(18%)"),
                          Text(
                            "TZS ${NumberFormat().format(0.18 * subTotal)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Shipping Cost"),
                          Text(
                            "TZS ${NumberFormat().format(order.shippingCost)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total"),
                          Text(
                            "TZS ${NumberFormat().format(invoice.totalAmount)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
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
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    isSaving = true;
                  });
                  try {
                    await Future.delayed(
                      const Duration(seconds: 2),
                    );

                    setState(() {
                      isSaving = false;
                    });
                  } catch (e) {
                    debugPrint(e.toString());
                  }
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
                    : const Text("Preview and Send Invoice"),
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text(error.toString()),
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
