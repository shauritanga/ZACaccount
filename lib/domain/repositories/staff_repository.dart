import 'package:zaccount/models/staff.dart';

abstract class StaffRepository {
  Future<List<StaffDetails>> getStaffs();
  Future<String> addStaff(StaffDetails staff);
  Future<void> removeStaff(String id);
  Future<void> updateStaff(String id, StaffDetails data);
  Stream<List<StaffDetails>> staffStreams();
}
