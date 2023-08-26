import 'dart:async';

import 'package:agendamentos/interface/crud_interface.dart';
import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/repository/api/firebase_repository.dart';
import 'package:agendamentos/repository/classes/preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../models/customer.dart';

class CustomerRepository extends FirebaseRepository implements CrudInterface {
  CustomerRepository._() : super(controller_name: 'customer');

  static final instance = CustomerRepository._();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

  @override
  Future<bool> delete(String id) async {
    bool res = await getFireCloud.doc(id).delete().then((value) => true).onError((error, stackTrace) => false);
    return res;
  }

  @override
  Future<String> save(data) async {
    DocumentReference doc = getFireCloud.doc(data.id);
    await doc.set(data.toMap());
    return doc.id;
  }

  @override
  Future<void> fetchAllStream(Function(List data) onDataProcessed) {
    // TODO: implement fetchAllStream
    throw UnimplementedError();
  }

  Future<List<Customer>> fetchAll() async {
    List<Customer> customers = [];
    Account currentUser = await PreferencesRepository.getPrefsCurrentUser();

    final response = await dio.get(apiURL, queryParameters: {
      'company_id': currentUser.company.id,
    });

    debugPrint(response.data);

    return customers;
  }
}
