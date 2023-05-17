import 'package:agendamentos/model/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerRepository {
  final String _collection = 'person';

  CustomerRepository._();

  static final instance = CustomerRepository._();

  Future save(Customer customer) async {
    var db = FirebaseFirestore.instance;

    await db
        .collection(_collection)
        .doc()
        .set(customer.toMap())
        .then((value) {})
        .onError((error, stackTrace) {});
  }

  Future<List<Customer>> fetchData() async {
    List<Customer> customers = [];
    var db = FirebaseFirestore.instance;
    var collections = await db.collection(_collection).get();

    for (var doc in collections.docs) {
      Customer customer = Customer.fromJson(doc.data());
      customers.add(customer);
    }

    return customers;
  }
}
