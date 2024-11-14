import 'package:zaccount/models/vendor.dart';

abstract class VendorRepository {
  Future<List<Vendor>> getVendors();
  Future<int> addVendor(Vendor vendor);
  Future<void> removeVendor(String id);
  Future<void> updateVendor(String id, Vendor data);
}
