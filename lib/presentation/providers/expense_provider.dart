import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/category_item.dart';
import 'package:zaccount/models/expense.dart';
import 'package:zaccount/models/product_item.dart';

final expenseStreamProvider = StreamProvider<List<Expense>>((ref) {
  return FirebaseFirestore.instance.collection('expenses').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Expense.fromDocument(doc)).toList(),
      );
});

class ExpenseListNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ExpenseListNotifier() : super([]) {
    // Automatically fetch products when the notifier is created
    _fetchInvoices();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void _fetchInvoices() async {
    try {
      final querySnapshot = await _firestore
          .collection('expenses')
          .orderBy('dueDate', descending: false)
          .get();
      List<Map<String, dynamic>> expenses = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
      state = expenses;
    } catch (e) {
      // Handle errors as needed
      print('Error fetching products: $e');
    }
  }
}

final expenseFurureProvider =
    StateNotifierProvider<ExpenseListNotifier, List<Map<String, dynamic>>>(
  (ref) => ExpenseListNotifier(),
);

final expenseProvider = StateNotifierProvider<ExpenseNotifier, Expense>((ref) {
  return ExpenseNotifier();
});

class ExpenseNotifier extends StateNotifier<Expense> {
  ExpenseNotifier() : super(Expense());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<String> addExpense() async {
    DocumentReference reference =
        await _firestore.collection("expenses").add(state.toJson());
    state = Expense();
    return reference.id;
  }
}
