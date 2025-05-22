import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreServices {
  FirestoreServices._();
  static final instance = FirestoreServices._();
  final _fireStore = FirebaseFirestore.instance;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final refrence = _fireStore.doc(path);
    debugPrint("Request Data $data");
    refrence.set(data);
  }

  Future<void> deleteData({required String path}) async {
    final refrence = _fireStore.doc(path);
    debugPrint("Path Data $path");
    refrence.delete();
  }

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
  }) async {
    final refrence = _fireStore.doc(path);
    final snapshot = await refrence.get();
    return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = await query.get();

    final result =
        snapshots.docs
            .map(
              (snapshot) =>
                  builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
            )
            .where((value) => value != null)
            .toList();

    if (sort != null) {
      result.sort();
    }
    return result;
  }

  Stream<T> documentstream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
  }) {
    final refrence = _fireStore.doc(path);
    final snapshots = refrence.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Stream<List<T>> collectionsStram<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _fireStore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result =
          snapshot.docs
              .map(
                (snapshot) => builder(
                  snapshot.data() as Map<String, dynamic>,
                  snapshot.id,
                ),
              )
              .where((value) => value != null)
              .toList();

      if (sort != null) {
        result.sort();
      }
      return result;
    });
  }
}
