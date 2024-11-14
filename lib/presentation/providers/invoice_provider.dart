import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/invoice.dart';
import 'package:zaccount/presentation/providers/order_provider.dart';

final customerStreamProvider = StreamProvider<List<Invoice>>((ref) {
  return FirebaseFirestore.instance.collection('invoices').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Invoice.fromDocument(doc)).toList(),
      );
});

final invoiceProvider = StateNotifierProvider<InvoiceNotifier, Invoice>((ref) {
  return InvoiceNotifier(ref: ref);
});

class InvoiceNotifier extends StateNotifier<Invoice> {
  InvoiceNotifier({required this.ref}) : super(Invoice());

  final FirebaseFirestore _firesore = FirebaseFirestore.instance;
  final Ref ref;

  void updateCustomerDetails({
    required String idOfCustomer,
    required String firstName,
    required String lastName,
    required double balance,
  }) {
    state = state.copyWith(
      customerId: idOfCustomer,
      customerFirstName: firstName,
      customerLastName: lastName,
      balance: balance,
    );
  }

  void updateInvoiceDetails(
      String terms, DateTime dueDate, DateTime invoiceDate, String invoiceNo) {
    state = state.copyWith(
      invoiceTerms: terms,
      dueDate: dueDate,
      invoiceDate: invoiceDate,
      invoiceNo: invoiceNo,
    );
  }

  void updateAdditionDetails(
      String paymethod, String thank, String? memo, int? latefee) {
    state = state.copyWith(
      thanksNote: thank,
      paymentMethod: paymethod,
      memo: memo,
      lateFees: latefee,
    );
  }

  Future<String> addInvoice() async {
    final order = await ref.read(orderProvider.notifier).addOrder();
    final orderId = order.id;
    state = state.copyWith(orderId: orderId);
    DocumentReference reference =
        await _firesore.collection("invoices").add(state.toJson());
    await _firesore
        .collection("orders")
        .doc(orderId)
        .update({'invoiceId': reference.id});
    return reference.id;
  }
}
