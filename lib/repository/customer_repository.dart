import 'dart:async';

import 'package:agendamentos/interface/crud_interface.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/customer.dart';

class CustomerRepository extends FirebaseRepository implements CrudInterface {
  CustomerRepository._() : super(collection: 'person');

  static final instance = CustomerRepository._();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

  @override
  Future<bool> delete(String id) async {
    bool res = await getFireCloud.doc(id).delete().then((value) => true).onError((error, stackTrace) => false);
    return res;
  }

  @override
  Future<void> fetchAllStream(Function(List<Customer>) onDataProcessed) async {
    List<Customer> customers = [];

    subscription = getFireCloud.snapshots().listen((querySnapshot) {
      customers.clear();

      for (var doc in querySnapshot.docs) {
        Customer customer = Customer.fromJson(doc.data(), doc.id);
        customers.add(customer);
      }

      onDataProcessed(customers);
    });
  }

  @override
  Future<String> save(data) async {
    DocumentReference doc = getFireCloud.doc(data.id);
    await doc.set(data.toMap());
    return doc.id;
  }
}
