import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/models/customer.dart';
import 'package:zaccount/models/order_invoice.dart';
import 'package:zaccount/presentation/providers/invoice_provider.dart';
import 'package:zaccount/presentation/providers/order_provider.dart';
import 'package:zaccount/screens/customers.dart';
import 'package:zaccount/screens/invoice_customer_details.dart';
import 'package:zaccount/screens/order_invoice_additional_details.dart';
import 'package:zaccount/screens/order_invoice_details.dart';
import 'package:zaccount/screens/product_order.dart';
import 'package:zaccount/screens/products.dart';

class AddInvoiceScreen extends ConsumerStatefulWidget {
  const AddInvoiceScreen({super.key});

  @override
  ConsumerState<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends ConsumerState<AddInvoiceScreen> {
  bool isSaving = false;
  bool isCustomerTouched = false;
  bool isProductTouched = false;
  Customer customer = Customer();

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderProvider);
    final invoice = ref.watch(invoiceProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: Text(
              "Cancel",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                decorationColor: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
        ),
        title: Text(
          "Add Invoice",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              try {
                await ref.read(invoiceProvider.notifier).addInvoice();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invoice created successfully"),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Invoice creation failed"),
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Text(
                "Save",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).primaryColor,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            ),
          ),
        ],
        leadingWidth: 100.w,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                const Text("CUSTOMER DETAILS"),
                SizedBox(height: 8.h),
                isCustomerTouched
                    ? Divider(
                        indent: 0.w,
                        height: 0,
                      )
                    : Divider(
                        indent: 44.w,
                        height: 0,
                      ),
                isCustomerTouched
                    ? GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  InvoiceCustomerDetails(customer: customer),
                            ),
                          );
                          ref
                              .read(orderProvider.notifier)
                              .updateOderCustomerDetails(
                                idOfCustomer: customer.id,
                                firstName: customer.firstName,
                                lastName: customer.lastName,
                              );
                          setState(() {
                            customer = result;
                            isCustomerTouched = false;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5.h),
                            Text(customer.displayName),
                            Text(customer.email),
                            Text(
                              "${customer.shippingAddress!.street},${customer.shippingAddress!.unitNumber}",
                            ),
                            Text(
                              "${customer.shippingAddress!.city},${customer.shippingAddress!.country}",
                            ),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      )
                    : TextButton.icon(
                        style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero),
                        ),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (ctx) => const CustomersScreen(),
                            ),
                          );
                          setState(() {
                            isCustomerTouched = true;
                            customer = result;
                          });
                        },
                        icon: Icon(
                          CupertinoIcons.add_circled_solid,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          "Add Customer",
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                isCustomerTouched
                    ? Divider(
                        indent: 0.w,
                        height: 0,
                      )
                    : Divider(
                        indent: 44.w,
                        height: 0,
                      ),
                SizedBox(height: 24.h),
                const Text("INVOICE ITEMS"),
                SizedBox(height: 8.h),
                isProductTouched
                    ? Divider(
                        indent: 0.w,
                        height: 0,
                      )
                    : Divider(
                        indent: 44.w,
                        height: 0,
                      ),
                isProductTouched
                    ? Column(
                        children: [
                          ListView.builder(
                            itemCount: order.items.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final productItem = order.items[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        productItem.item,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                          "TZS ${NumberFormat().format(productItem.amount)}"),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text("SKU: ${productItem.sku}"),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Text("Quantity ${productItem.quantity}"),
                                      SizedBox(width: 8.w),
                                      SizedBox(width: 8.w),
                                      Text(
                                          "Item Price TZS ${NumberFormat().format(productItem.rate)}"),
                                    ],
                                  ),
                                  const Divider(
                                    height: 16,
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      )
                    : Container(),
                TextButton.icon(
                  style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const ProductsScreen(),
                      ),
                    );

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) =>
                            ProductOrderDetails(productInfo: result),
                      ),
                    );
                    setState(() {
                      isProductTouched = true;
                    });
                  },
                  icon: Icon(
                    CupertinoIcons.add_circled_solid,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(
                    "Add Product",
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(indent: 44.w, height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("subtotal"),
                  trailing: Text(
                    "Tsh ${NumberFormat().format(order.totalAmount)}",
                  ),
                ),
                const Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("VAT(18%)"),
                  trailing: Text(
                    "Tsh ${NumberFormat().format(order.totalAmount * 0.18)}",
                  ),
                ),
                const Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Shipping cost"),
                  trailing: Text(
                    "Tsh ${NumberFormat().format(order.shippingCost)}",
                  ),
                ),
                const Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Total"),
                  trailing: Text(
                    "Tsh ${NumberFormat().format(order.totalAmount + order.shippingCost + (order.totalAmount * 0.18))}",
                  ),
                ),
                const Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Deposited"),
                  trailing: Text(
                    "Tsh ${NumberFormat().format(invoice.deposit)}",
                  ),
                ),
                const Divider(height: 0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Balance"),
                  trailing: Text(
                    "Tsh ${NumberFormat().format(order.totalAmount + order.totalAmount * 0.18 - invoice.deposit)}",
                  ),
                ),
                SizedBox(height: 24.h),
                const Text("INVOICE DETAILS"),
                const Divider(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      useSafeArea: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      builder: (BuildContext context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 1.0, //set this as you want
                          maxChildSize: 1.0, //set this as you want
                          minChildSize: 1.0, //set this as you want
                          expand: true,
                          builder: (context, scrollController) {
                            return OrderInvoiceEditDetails(invoice: invoice);
                          },
                        );
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice No. ${invoice.invoiceNo}",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        "Created Date. ${DateFormat.yMMMd().format(invoice.invoiceDate)}",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        "Due Date. ${DateFormat.yMMMd().format(invoice.dueDate)}",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        "Invoice Terms. ${invoice.invoiceTerms}",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(height: 28.h),
                const Text("ADDITIONAL DETAILS"),
                const Divider(),
                GestureDetector(
                  onTap: () async {
                    OrderInvoice orderInvoice = OrderInvoice(
                      paymentMethod: invoice.paymentMethod,
                      shippingMethod: order.shippingMethod,
                      customerNote: invoice.thanksNote,
                      memo: invoice.memo,
                      lateFees: 36,
                    );
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      useSafeArea: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      builder: (BuildContext context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 1.0, //set this as you want
                          maxChildSize: 1.0, //set this as you want
                          minChildSize: 1.0, //set this as you want
                          expand: true,
                          builder: (context, scrollController) {
                            return OrderInvoiceAdditionalEditDetails(
                              invoice: orderInvoice,
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Method: ${invoice.paymentMethod}",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Shipping Method: ${order.shippingMethod}",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        "Due Date. ${DateFormat.yMMMd().format(invoice.dueDate)}",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Notes to customer",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      SizedBox(height: 8.h),
                      Text(invoice.thanksNote),
                    ],
                  ),
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
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColor),
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
  }
}
