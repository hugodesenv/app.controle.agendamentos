import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerRepository extends FirebaseRepository {
  CustomerRepository._() : super(collection: 'person');

  static final instance = CustomerRepository._();

  Future<String> save(Customer customer) async {
    DocumentReference doc = getFireCloud.doc(customer.id);
    await doc.set(customer.toMap());
    return doc.id;
  }

  Future<List<Customer>> fetchData() async {
    List<Customer> customers = [];
    var collections = await getFireCloud.get();

    for (var doc in collections.docs) {
      Customer customer = Customer.fromJson(doc.data(), doc.id);
      customers.add(customer);
    }

    return customers;
  }

  Future<bool> delete(String id) async {
    bool res = await getFireCloud.doc(id).delete().then((value) => true).onError((error, stackTrace) => false);
    return res;
  }
}
