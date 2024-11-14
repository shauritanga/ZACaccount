import 'package:zaccount/data/local_database_helper.dart';
import 'package:zaccount/models/customer.dart';

class CustomerDataSource {
  CustomerDataSource({required this.databaseHelper});
  final DatabaseHelper databaseHelper;

  Future<void> insertCustomer(Customer customer) async {
    await databaseHelper.insert('customers', customer.toJson());
  }

  Future<List<Customer>> getCustomers() async {
    List<Map<String, dynamic>> maps =
        await databaseHelper.fetchAll("customers");
    List<Customer> customers = List.generate(maps.length, (index) {
      return Customer.fromJson(maps[index]);
    });
    return customers;
  }

  Future<void> updateCustomer(Customer customer) async {
    await databaseHelper.update(
      'customers',
      customer.toJson(),
      'id = ?',
      [customer.id],
    );
  }

  Future<void> deleteCustomer(String id) async {
    await databaseHelper.delete('customers', 'id = ?', [id]);
  }
}
