import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/presentation/providers/expense_provider.dart';
import 'package:zaccount/screens/add_expense_service.dart';
import 'package:zaccount/screens/expense_accounts.dart';
import 'package:zaccount/screens/expense_payment_details.dart';
import 'package:zaccount/screens/payees.dart';
import 'package:zaccount/screens/product_order_expense.dart';
import 'package:zaccount/screens/products.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  bool payeeDetailsToucched = false;
  bool expenseAccountTouched = false;
  bool paymentAndReferenceTourched = false;
  bool addProductAndServiceTouched = false;
  bool addProductTouched = false;
  bool addServiceTouched = false;
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    final expense = ref.watch(expenseProvider);
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
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).primaryColor,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
        title: Text(
          "Add Expense",
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              const Text("PAYEE DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                indent: payeeDetailsToucched ? 0 : 44.w,
                height: 0,
                thickness: 0.3,
              ),
              payeeDetailsToucched
                  ? Text(expense.payee)
                  : TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (ctx) => const PayeesScreen(),
                          ),
                        );
                        setState(() {
                          payeeDetailsToucched = true;
                        });
                      },
                      label: Text(
                        "Add Payee",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      icon: Icon(
                        CupertinoIcons.add_circled,
                        color: Theme.of(context).primaryColor,
                      ),
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                    ),
              Divider(
                indent: payeeDetailsToucched ? 0 : 44.w,
                height: 0,
                thickness: 0.3,
              ),
              SizedBox(height: 32.h),
              const Text("EXPENSE ACCOUNT"),
              SizedBox(height: 8.h),
              Divider(
                indent: expenseAccountTouched ? 0 : 44.w,
                height: 0,
                thickness: 0.3,
              ),
              expenseAccountTouched
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Text(expense.paymentAccount),
                        SizedBox(height: 8.h),
                      ],
                    )
                  : TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (ctx) => const ExpenseAccountsScreen(),
                          ),
                        );
                        setState(() {
                          expenseAccountTouched = true;
                        });
                      },
                      label: Text(
                        "Add Expense Account",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      icon: Icon(
                        CupertinoIcons.add_circled,
                        color: Theme.of(context).primaryColor,
                      ),
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                    ),
              Divider(
                indent: expenseAccountTouched ? 0 : 44.w,
                height: 0,
                thickness: 0.3,
              ),
              SizedBox(height: 32.h),
              const Text("PAYMENT & REFERENCE DETAILS"),
              SizedBox(height: 8.h),
              Divider(
                indent: paymentAndReferenceTourched ? 0 : 44.w,
                height: 0,
                thickness: 0.3,
              ),
              paymentAndReferenceTourched
                  ? Column(
                      children: [
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            const Text("Payment Date:"),
                            SizedBox(width: 12.w),
                            Text(
                              DateFormat.yMMMd().format(expense.paymentDate),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Payment Method:"),
                            SizedBox(width: 12.w),
                            Text(
                              expense.paymentMethod,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Reference No:"),
                            SizedBox(width: 12.w),
                            Text(
                              expense.referenceNo,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Permit No:"),
                            SizedBox(width: 12.w),
                            Text(
                              expense.permitNo,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Notes:"),
                            SizedBox(width: 12.w),
                            Text(
                              expense.memo,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                      ],
                    )
                  : TextButton.icon(
                      onPressed: () async {
                        await showModalBottomSheet(
                          backgroundColor: Colors.white,
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
                                return const ExpensePaymentDetailsForm(); //whatever you're returning, does not have to be a Container
                              },
                            );
                          },
                        );
                        setState(() {
                          paymentAndReferenceTourched = true;
                        });
                      },
                      label: Text(
                        "Add Payments & Reference",
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      icon: Icon(
                        CupertinoIcons.add_circled,
                        color: Theme.of(context).primaryColor,
                      ),
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                    ),
              Divider(
                indent: paymentAndReferenceTourched ? 0 : 44.w,
                height: 0,
                thickness: 0.3,
              ),
              SizedBox(height: 32.h),
              const Text("PRODUCTD AND SERVICES"),
              SizedBox(height: 8.h),
              Divider(
                indent: addProductAndServiceTouched ? 0 : 44.w,
                height: 0,
                thickness: 0.3,
              ),
              addProductAndServiceTouched
                  ? Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final productItem = expense.productItems[index];

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
                                        "Item Price TZS ${NumberFormat().format(productItem.amount)}"),
                                  ],
                                )
                              ],
                            );
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: expense.productItems.length,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final categoryItem = expense.categoryItems[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index == 0 ? const Divider() : Container(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      categoryItem.category,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                        "TZS ${NumberFormat().format(categoryItem.amount)}"),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text("Dscription: ${categoryItem.description}"),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Text("Quantity ${categoryItem.quantity}"),
                                    SizedBox(width: 8.w),
                                    SizedBox(width: 8.w),
                                    Text(
                                        "Item Price TZS ${NumberFormat().format(categoryItem.rate)}"),
                                  ],
                                ),
                                index == expense.categoryItems.length - 1
                                    ? const Divider()
                                    : Container(),
                              ],
                            );
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: expense.categoryItems.length,
                        )
                      ],
                    )
                  : Container(),
              TextButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) => const ProductsScreen(),
                    ),
                  );

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) =>
                          ProductOrderExpenseDetails(productInfo: result),
                    ),
                  );
                  setState(() {
                    addProductAndServiceTouched = true;
                    addProductTouched = true;
                  });
                },
                label: Text(
                  "Add Product",
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                icon: Icon(
                  CupertinoIcons.add_circled,
                  color: Theme.of(context).primaryColor,
                ),
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
              ),
              Divider(
                indent: addProductTouched ? 0 : 44.w,
                height: 0,
                thickness: 0.3,
              ),
              SizedBox(height: 8.h),
              TextButton.icon(
                onPressed: () async {
                  await showModalBottomSheet(
                    backgroundColor: Colors.white,
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
                          return const AddExpenseServiceDetailsForm(); //whatever you're returning, does not have to be a Container
                        },
                      );
                    },
                  );
                  setState(() {
                    addProductAndServiceTouched = true;
                    addServiceTouched = true;
                  });
                },
                label: Text(
                  "Add Services",
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                icon: Icon(
                  CupertinoIcons.add_circled,
                  color: Theme.of(context).primaryColor,
                ),
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
              ),
              Divider(
                indent: addServiceTouched ? 0 : 44.w,
                height: 0,
                thickness: 0.3,
              ),
              SizedBox(height: 38.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("TOTAL AMOUNT"),
                  Text(
                    "TZS ${NumberFormat().format(expense.totalAmount)}",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              const Divider(
                indent: 0,
                height: 0,
                thickness: 0.3,
              ),
            ],
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
                await ref.read(expenseProvider.notifier).addExpense();

                setState(() {
                  isSaving = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    content: const Text("expense created"),
                  ),
                );
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    content: const Text("expense creation failed"),
                  ),
                );
                Navigator.pop(context);
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
                : const Text("Add Expense"),
          ),
        ),
      ),
    );
  }
}
