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

  //@@@PENBSAR DUM JEITO MELHOR PRA PROGRAMAR SÓ A PARTE DE DENTRO DO BLOC
  Future fetchStream(Function(List<Customer>) callbackCustomers) async {
    List<Customer> customers = [];

    await for (var querySnapshot in getFireCloud.snapshots()) {
      customers.clear();
      for (var doc in querySnapshot.docs) {
        Customer customer = Customer.fromJson(doc.data(), doc.id);
        customers.add(customer);
      }
      print("** blz, agora vamos chamar callback e atualizar no bloC");
      callbackCustomers(customers);
    }
  }

  @override
  Future<String> save(data) async {
    DocumentReference doc = getFireCloud.doc(data.id);
    await doc.set(data.toMap());
    return doc.id;
  }

  @override
  Future<List> fetchAll() {
    //@@@@REMOVER ISSO AQUI E MUDAR TODOS PRO STREAM!!! PRA MANTER UM PADRÃO! :)
    // TODO: implement fetchAll
    throw UnimplementedError();
  }
}
