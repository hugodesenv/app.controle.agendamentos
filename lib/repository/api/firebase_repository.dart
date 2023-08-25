import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

/**
 * Change this classname to Dio...
 */
class FirebaseRepository {
  final dio = Dio();
  final _apiURL = "http://192.168.1.247:3000";
  final String? _collection;

  String get apiURL {
    return '$_apiURL/$_collection';
  }

  FirebaseRepository({required String collection}) : _collection = collection;

  CollectionReference<Map<String, dynamic>> get getFireCloud => FirebaseFirestore.instance.collection(_collection ?? '');
}
