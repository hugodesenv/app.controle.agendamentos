import 'dart:async';

import 'package:agendamentos/enum/database_enum.dart';
import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:agendamentos/utils/preferences_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../../models/customer.dart';

class CustomerRepository extends FirebaseRepository implements CrudRepository {
  CustomerRepository._() : super(controller_name: 'customer');

  static final instance = CustomerRepository._();
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

  @override
  Future<Map<String, dynamic>> delete(String id) async {
    try {
      var response = await dio.delete('$apiURL/$id');
      bool deleted = response.data?['rows_affected'] > 0;
      return {
        "success": deleted,
        "message": deleted
            ? "Exclusão efetuada com sucesso!"
            : "Nenhum registro foi afetado, verifique!",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "message": e.response?.data['friendlyMessage'],
      };
    }
  }

  @override
  Future<Map> findAll() async {
    List<Customer> customers = [];
    Account currentUser = await PreferencesUtil.getPrefsCurrentUser();

    var response = await dio.get('$apiURL/${currentUser.company.id}');
    for (var data in response.data) {
      Customer customer = Customer.fromJson(data);
      customers.add(customer);
    }

    return {
      "customers": customers,
    };
  }

  @override
  Future<Map> update(data) async {
    Customer customer = data as Customer;
    try {
      var data = {...customer.toMap(), 'action': DatabaseAction.UPDATE.text()};
      var res = await dio.patch('$apiURL/${customer.id}', data: data);
      return res.data;
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  @override
  Future<Map> save(data) async {
    Customer customer = data as Customer;
    try {
      Map data = {...customer.toMap(), 'action': DatabaseAction.INSERT.text()};
      await dio.post(apiURL, data: data);
      return {
        "success": true,
        "message": "Operação efetuada!",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
}
