import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/expense_account.dart';

final expenseAccountStreamProvider =
    StreamProvider<List<ExpenseAccount>>((ref) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return firestore.collection("expense-accounts").snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => ExpenseAccount.fromDocument(doc)).toList());
});
