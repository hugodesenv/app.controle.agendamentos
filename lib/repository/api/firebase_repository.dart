import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  final String? _collection;

  FirebaseRepository({required String collection}) : _collection = collection;

  CollectionReference<Map<String, dynamic>> get getFireCloud => FirebaseFirestore.instance.collection(_collection ?? '');
}
