import 'package:zaccount/data/local_database_helper.dart';
import 'package:zaccount/models/vendor.dart';

class VendorDataSource {
  VendorDataSource({required this.databaseHelper});
  final DatabaseHelper databaseHelper;

  Future<int> insertVendor(Vendor vendor) async {
    return await databaseHelper.insert('vendors', vendor.toJson());
  }

  Future<List<Vendor>> getVendors() async {
    List<Map<String, dynamic>> maps = await databaseHelper.fetchAll("vendors");
    List<Vendor> vendors = List.generate(maps.length, (index) {
      return Vendor.fromJson(maps[index]);
    });
    return vendors;
  }

  Future<void> updateVendor(Vendor vendor) async {
    await databaseHelper.update(
      'vendors',
      vendor.toJson(),
      'id = ?',
      [vendor.id],
    );
  }

  Future<void> deleteVendor(String id) async {
    await databaseHelper.delete('vendors', 'id = ?', [id]);
  }
}
