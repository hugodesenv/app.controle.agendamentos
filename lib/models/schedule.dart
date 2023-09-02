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
      {required String? id,
      required DateTime? scheduleDate,
      required double? totalMinutes,
      required double? totalPrice,
      required Employee? employee,
      required Customer? customer})
      : _id = id ?? "",
        _scheduleDate = scheduleDate ?? DateTime.now(),
        _totalMinutes = totalMinutes ?? 0,
        _totalPrice = totalPrice ?? 0,
        _employee = employee ?? Employee.empty(),
        _customer = customer ?? Customer.empty();

  factory Schedule.fromJson(Map data) {
    return Schedule(
      id: data['id'],
      scheduleDate: data['schedule_date'],
      totalMinutes: data['total_minutes'],
      totalPrice: data['total_price'],
      employee: Employee.fromJson(data['employee']),
      customer: Customer.fromJson(data['customer']),
    );
  }

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
