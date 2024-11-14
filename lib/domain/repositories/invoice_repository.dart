import 'package:zaccount/models/invoice.dart';

abstract class InvoiceRepository {
  Future<List<Invoice>> getInvoices();
  Future<void> addInvoice(Invoice invoice);
  Future<void> deleteInvoice(String id);
  Future<void> updateInvoice(String id, Map data);
}
