import 'package:zaccount/data/datascource/vendor_data_source.dart';
import 'package:zaccount/data/local_database_helper.dart';
import 'package:zaccount/domain/repositories/vendor_repository.dart';
import 'package:zaccount/models/vendor.dart';

class VendorRepositoryImpl extends VendorRepository {
  final VendorDataSource vendorDataSource = VendorDataSource(
    databaseHelper: DatabaseHelper(),
  );
  @override
  Future<int> addVendor(Vendor vendor) async {
    return await vendorDataSource.insertVendor(vendor);
  }

  @override
  Future<void> removeVendor(String id) async {
    await vendorDataSource.deleteVendor(id);
  }

  @override
  Future<List<Vendor>> getVendors() async {
    return await vendorDataSource.getVendors();
  }

  @override
  Future<void> updateVendor(String id, Vendor data) async {
    await vendorDataSource.updateVendor(data);
  }
}
