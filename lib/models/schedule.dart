import 'package:agendamentos/models/customer.dart';

import 'employee.dart';

class Schedule {
  String _id;
  DateTime _scheduleDate;
  double _totalMinutes;
  double _totalPrice;
  Customer _customer;
  Employee _employee;

  Schedule(
      {required String id,
      required DateTime scheduleDate,
      required double totalMinutes,
      required double totalPrice,
      required employee,
      required Customer customer})
      : _id = id,
        _scheduleDate = scheduleDate,
        _totalMinutes = totalMinutes,
        _totalPrice = totalPrice,
        _employee = employee,
        _customer = customer;

  Customer get customer => _customer;

  set customer(Customer value) {
    _customer = value;
  }

  double get totalPrice => _totalPrice;

  set totalPrice(double value) {
    _totalPrice = value;
  }

  double get totalMinutes => _totalMinutes;

  set totalMinutes(double value) {
    _totalMinutes = value;
  }

  DateTime get scheduleDate => _scheduleDate;

  set scheduleDate(DateTime value) {
    _scheduleDate = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Employee get employee => _employee;

  set employee(Employee value) {
    _employee = value;
  }
}
