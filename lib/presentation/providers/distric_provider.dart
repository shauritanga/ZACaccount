import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zaccount/models/district.dart';

final districtFutureProvider = FutureProvider<List<District>>((ref) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot snapshot = await firestore.collection("districts").get();
  final districts = snapshot.docs
      .map((doc) => District.fromMap(doc.data() as Map<String, dynamic>))
      .toList();
  return districts;
});

final searchQueryProvider = StateProvider<String>((ref) => '');
