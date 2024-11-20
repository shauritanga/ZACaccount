import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/invoice.dart';
import 'package:zaccount/models/vendor.dart';
import 'package:zaccount/presentation/providers/order_provider.dart';

final invoiceStreamProvider = StreamProvider<List<Invoice>>((ref) {
  return FirebaseFirestore.instance.collection('invoices').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Invoice.fromDocument(doc)).toList(),
      );
});

final invoiceFutureProvider =
    FutureProvider.family<Invoice, String>((ref, invoiceId) async {
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection("invoices")
      .doc(invoiceId)
      .get();
  Invoice invoice = Invoice.fromJson(
    snapshot.id,
    snapshot.data() as Map<String, dynamic>,
  );
  return invoice;
});

final invoicesProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return FirebaseFirestore.instance.collection('invoices').snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
      );
});

class InvoiceListNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  InvoiceListNotifier() : super([]) {
    // Automatically fetch products when the notifier is created
    _fetchInvoices();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void _fetchInvoices() async {
    try {
      final querySnapshot = await _firestore
          .collection('invoices')
          .orderBy('invoiceDate', descending: false)
          .get();
      List<Map<String, dynamic>> invoices = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
      state = invoices;
    } catch (e) {
      // Handle errors as needed
      print('Error fetching products: $e');
    }
  }
}

final invoicesFurureProvider =
    StateNotifierProvider<InvoiceListNotifier, List<Map<String, dynamic>>>(
  (ref) => InvoiceListNotifier(),
);

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
    try {
      final order = await ref.read(orderProvider.notifier).addOrder();
      final orderId = order.id;
      DocumentSnapshot snapshot =
          await _firesore.collection("orders").doc(orderId).get();
      final ordeFromFirebase = snapshot.data() as Map<String, dynamic>;
      final balance = ordeFromFirebase['totalAmount'];
      state = state.copyWith(
          orderId: orderId,
          balance: balance + balance * 0.18,
          totalAmount: balance + balance * 0.18);
      DocumentReference reference =
          await _firesore.collection("invoices").add(state.toJson());
      await _firesore
          .collection("orders")
          .doc(orderId)
          .update({'invoiceId': reference.id});
      state = Invoice();
      return reference.id;
    } catch (e) {
      return '';
    }
  }
}
