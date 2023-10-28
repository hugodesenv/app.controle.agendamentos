import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

abstract class CrudRepository {
  Future<Map> delete(String id);
  Future<Map> save(data);
  Future<Map> update(data);
  Future<Map> findAll();
}

class FirebaseRepository {
  final dio = Dio();
  //final _apiURL = "http://10.0.0.199:3000";
  final _apiURL = "http://192.168.1.247:3000";
  final String? _controller_name;

  String get apiURL {
    return '$_apiURL/$_controller_name';
  }

  FirebaseRepository({required String controller_name})
      : _controller_name = controller_name;

  CollectionReference<Map<String, dynamic>> get getFireCloud =>
      FirebaseFirestore.instance.collection(_controller_name ?? '');
}
