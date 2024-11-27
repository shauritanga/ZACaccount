import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zaccount/domain/repositories/firestore_repository.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final repositoryProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirestoreRepository(firestore);
});