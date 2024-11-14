import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/category_item.dart';
import 'package:zaccount/models/expense.dart';
import 'package:zaccount/models/product_item.dart';

final expenseProvider = StateNotifierProvider<ExpenseNotifier, Expense>((ref) {
  return ExpenseNotifier();
});

class ExpenseNotifier extends StateNotifier<Expense> {
  ExpenseNotifier() : super(Expense());

  void updatePayee(String payee) {
    state = state.copyWith(payee: payee);
  }

  void updateExpenseAccount(String account) {
    state = state.copyWith(paymentAccount: account);
  }

  void updatePaymentDetails({
    required String note,
    required String reference,
    required String permit,
    required DateTime paymentDate,
    required String paymentMethod,
  }) {
    state = state.copyWith(
      referenceNo: reference,
      permitNo: permit,
      memo: note,
      paymentDate: paymentDate,
      paymentMethod: paymentMethod,
    );
  }

  void updateproductItem(ProductItem productItem) {
    state = state.copyWith(
      productItems: [...state.productItems, productItem],
      totalAmount: state.totalAmount + productItem.amount,
    );
  }

  void updateCategoryItem(CategoryItem categoryItem) {
    state = state.copyWith(
      categoryItems: [...state.categoryItems, categoryItem],
      totalAmount: state.totalAmount + categoryItem.amount,
    );
  }
}
