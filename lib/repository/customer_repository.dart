import 'package:agendamentos/model/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerRepository {
  final _fireCloud = FirebaseFirestore.instance.collection('person');

  CustomerRepository._();

  static final instance = CustomerRepository._();

  Future save(Customer customer) async {
    await _fireCloud.doc().set(customer.toMap()).then((value) {}).onError((error, stackTrace) {});
  }

  Future<List<Customer>> fetchData() async {
    List<Customer> customers = [];
    var collections = await _fireCloud.get();

    for (var doc in collections.docs) {
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
