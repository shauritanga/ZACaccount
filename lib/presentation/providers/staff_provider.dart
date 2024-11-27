import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/data/repositories/staff_repository.dart';
import 'package:zaccount/models/staff.dart';

final staffStreamProvider =
    StreamProvider.autoDispose<List<StaffDetails>>((ref) {
  StaffRepositoryImpl staffRepositoryImpl = StaffRepositoryImpl();
  return staffRepositoryImpl.staffStreams();
});

final staffFutureProvider = FutureProvider<List<StaffDetails>>((ref) async {
  final staffs = ref.watch(staffProvider.notifier).getstaff();
  return staffs;
});

final staffProvider = StateNotifierProvider<StaffNotifier, StaffDetails>((ref) {
  return StaffNotifier();
});

class StaffNotifier extends StateNotifier<StaffDetails> {
  StaffNotifier()
      : super(
          StaffDetails(
            id: '',
            updatedAt: DateTime.now(),
            createdAt: DateTime.now(),
          ),
        );

  StaffRepositoryImpl staffRepositoryImpl = StaffRepositoryImpl();

  void updatePersonalInfo(
      {String firstName = "",
      String lastName = "",
      String email = "",
      String companyId = "",
      String phone = ""}) {
    state = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }

  updateAdditionalInfo({
    required String department,
    required String roleName,
    required String storeId,
    required String storeName,
    required String access,
    required String storeLocation,
  }) {
    state = state.copyWith(
        department: department,
        role: roleName,
        storeId: storeId,
        storeName: storeName,
        storeLocation: storeLocation);
  }

  Future<String> saveStaff(StaffDetails staff) async {
    return await staffRepositoryImpl.addStaff(staff);
  }

  Future<List<StaffDetails>> getstaff() async {
    return await staffRepositoryImpl.getStaffs();
  }
}
