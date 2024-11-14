import 'package:zaccount/models/customer.dart';

abstract class CustomerRepository {
  Future<List<Customer>> fetchCustomers();
  Future<void> addCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
  Future<void> deleteCustomer(String id);
}
