import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/income_account.dart';

final incomeAccountStreamProvider =
    StreamProvider.autoDispose<List<IncomeAccount>>((ref) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return firestore.collection("income-accounts").snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => IncomeAccount.fromDocument(doc)).toList());
});
