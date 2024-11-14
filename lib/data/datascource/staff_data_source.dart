import 'package:zaccount/data/local_database_helper.dart';
import 'package:zaccount/models/staff.dart';

class StaffDataSource {
  StaffDataSource({required this.databaseHelper});
  final DatabaseHelper databaseHelper;

  Future<int> insertStaff(StaffDetails staff) async {
    return await databaseHelper.insert('staff', staff.toMap());
  }

  Future<List<StaffDetails>> getStaffs() async {
    List<Map<String, dynamic>> maps = await databaseHelper.fetchAll("staff");
    List<StaffDetails> staffs = List.generate(maps.length, (index) {
      return StaffDetails.fromMap(maps[index]);
    });
    return staffs;
  }

  Future<void> updateStaff(StaffDetails staff) async {
    await databaseHelper.update(
      'staffs',
      staff.toMap(),
      'id = ?',
      [staff.id],
    );
  }

  Future<void> deleteStaff(String id) async {
    await databaseHelper.delete('staff', 'id = ?', [id]);
  }
}
