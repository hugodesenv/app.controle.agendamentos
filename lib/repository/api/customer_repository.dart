import 'dart:async';
import 'dart:developer';

import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/repository/api/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../../models/customer.dart';
import '../classes/preferences_repository.dart';

class CustomerRepository extends FirebaseRepository {
  CustomerRepository._() : super(controller_name: 'customer');

  static final instance = CustomerRepository._();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

  Future<Map<String, dynamic>> delete(String id) async {
    try {
      var response = await dio.delete('$apiURL/$id');
      bool deleted = response.data?['rows_affected'] > 0;
      return {
        "success": deleted,
        "message": deleted ? "Exclusão efetuada com sucesso!" : "Nenhum registro foi afetado, verifique!",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "message": e.response?.data['friendlyMessage'],
      };
    }
  }

  Future<void> save(Customer customer) async {
    /// TRATAR...
    try {
      Map data = {...customer.toMap(), "action": "insert"};
      data['email'] = "hugo_sbo04@hotmail.com";
      var response = await dio.post(apiURL, data: data);
    } on DioException catch (e) {}
  }

  Future<void> update(Customer customer) async {}

  Future<List<Customer>> findAll() async {
    List<Customer> customers = [];
    Account currentUser = await PreferencesRepository.getPrefsCurrentUser();

    var response = await dio.get('$apiURL/${currentUser.company.id}');
    for (var data in response.data) {
      Customer customer = Customer.fromJson(data);
      customers.add(customer);
    }

    return customers;
  }
}
