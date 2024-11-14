import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zaccount/domain/repositories/staff_repository.dart';
import 'package:zaccount/models/staff.dart';

class StaffRepositoryImpl extends StaffRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<String> addStaff(StaffDetails staff) async {
    final reference = await _firestore.collection("staffs").add(staff.toMap());
    return reference.id;
  }

  @override
  Future<List<StaffDetails>> getStaffs() async {
    QuerySnapshot snapshot = await _firestore.collection("staffs").get();
    List<StaffDetails> staffs = snapshot.docs
        .map((doc) => StaffDetails.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return staffs;
  }

  @override
  Future<void> removeStaff(String id) async {
    await _firestore.collection("staffs").doc(id).delete();
  }

  @override
  Future<void> updateStaff(String id, StaffDetails data) async {
    await _firestore.collection("staffs").doc(id).set(data.toMap());
  }

  @override
  Stream<List<StaffDetails>> staffStreams() {
    return FirebaseFirestore.instance.collection('staffs').snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => StaffDetails.fromDocument(doc)).toList(),
        );
  }
}
