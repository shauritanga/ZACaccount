import 'package:zaccount/data/datascource/customer_data_source.dart';
import 'package:zaccount/data/local_database_helper.dart';
import 'package:zaccount/domain/repositories/customer_repositoy.dart';
import 'package:zaccount/models/customer.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final CustomerDataSource customerDataSource =
      CustomerDataSource(databaseHelper: DatabaseHelper());
  @override
  Future<void> addCustomer(Customer customer) async {
    await customerDataSource.insertCustomer(customer);
  }

  @override
  Future<List<Customer>> fetchCustomers() async {
    return await customerDataSource.getCustomers();
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await customerDataSource.updateCustomer(customer);
  }

  @override
  Future<void> deleteCustomer(String id) async {
    await customerDataSource.deleteCustomer(id);
  }
}
