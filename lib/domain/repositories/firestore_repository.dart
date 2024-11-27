import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zaccount/models/customer.dart';
import 'package:zaccount/models/invoice.dart';
import 'package:zaccount/models/order.dart';

class FirestoreRepository {
  final FirebaseFirestore firestore;

  FirestoreRepository(this.firestore);

  Future<Invoice> fetchInvoice(String invoiceId) async {
    final snapshot =
        await firestore.collection('invoices').doc(invoiceId).get();
    if (snapshot.exists) {
      return Invoice.fromJson(snapshot.id, snapshot.data()!);
    } else {
      throw Exception('Invoice not found');
    }
  }

  Future<Orders> fetchOrder(String orderId) async {
    final snapshot = await firestore.collection('orders').doc(orderId).get();
    if (snapshot.exists) {
      return Orders.fromDocument(snapshot);
    } else {
      throw Exception('Order not found');
    }
  }

  Future<Customer> fetchCustomer(String customerId) async {
    final snapshot =
        await firestore.collection('customers').doc(customerId).get();
    if (snapshot.exists) {
      return Customer.fromDocument(snapshot);
    } else {
      throw Exception('Order not found');
    }
  }

  Future<bool> deleteInvoice(String invoiceId) async {
    try {
      await firestore.collection('invoices').doc(invoiceId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
