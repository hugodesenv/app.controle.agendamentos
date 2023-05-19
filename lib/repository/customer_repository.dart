import 'package:agendamentos/model/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerRepository {
  final _fireCloud = FirebaseFirestore.instance.collection('person');

  CustomerRepository._();

  static final instance = CustomerRepository._();

  Future<String> save(Customer customer) async {
    DocumentReference doc = _fireCloud.doc(customer.id);
    await doc.set(customer.toMap());
    return doc.id;
  }

  Future<List<Customer>> fetchData() async {
    List<Customer> customers = [];
    var collections = await _fireCloud.get();

    for (var doc in collections.docs) {
      print("** fetch data: ${doc.id}");
      Customer customer = Customer.fromJson(doc.data(), doc.id);
      customers.add(customer);
    }

    return customers;
  }

  Future<bool> delete(String id) async {
    bool res = await _fireCloud
        .doc(id)
        .delete()
        .then((value) => true)
        .onError((error, stackTrace) => false);

    return res;
  }
}
