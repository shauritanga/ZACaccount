import 'package:zaccount/data/local_database_helper.dart';
import 'package:zaccount/models/invoice.dart';

class InvoiceDataSource {
  InvoiceDataSource({required this.databaseHelper});
  final DatabaseHelper databaseHelper;

  Future<void> insertInvoice(Invoice invoice) async {
    await databaseHelper.insert('invoices', invoice.toJson());
  }

  Future<List<Invoice>> getInvoices() async {
    List<Map<String, dynamic>> maps = await databaseHelper.fetchAll("invoices");
    List<Invoice> invoices = List.generate(maps.length, (index) {
      return Invoice.fromJson("78", maps[index]);
    });
    return invoices;
  }

  Future<void> updateInvoice(Invoice invoice) async {
    await databaseHelper.update(
      'invoices',
      invoice.toJson(),
      'id = ?',
      [invoice.id],
    );
  }

  Future<void> deleteInvoice(String id) async {
    await databaseHelper.delete('invoices', 'id = ?', [id]);
  }
}
