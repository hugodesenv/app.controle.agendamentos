import 'package:agendamentos/interface/crud_interface.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/customer.dart';

class CustomerRepository extends FirebaseRepository implements CrudInterface {
  CustomerRepository._() : super(collection: 'person');

  static final instance = CustomerRepository._();

  @override
  Future<bool> delete(String id) async {
    bool res = await getFireCloud.doc(id).delete().then((value) => true).onError((error, stackTrace) => false);
    return res;
  }

  @override
  Future<List> fetchAll() async {
    List<Customer> customers = [];
    var collections = await getFireCloud.get();

    for (var doc in collections.docs) {
      Customer customer = Customer.fromJson(doc.data(), doc.id);
      customers.add(customer);
    }

    return customers;
  }

  @override
  Future<String> save(data) async {
    DocumentReference doc = getFireCloud.doc(data.id);
    await doc.set(data.toMap());
    return doc.id;
  }
}
