import 'package:agendamentos/models/customer.dart';
import 'package:agendamentos/utils/schedule_utils.dart';

import 'employee.dart';

class Schedule {
  String _id;
  DateTime _scheduleDate;
  int _totalMinutes;
  double _totalPrice;
  Customer _customer;
  Employee _employee;
  ScheduleSituationEnum _situation;

  Schedule({
    required String? id,
    required DateTime? scheduleDate,
    required int? totalMinutes,
    required double? totalPrice,
    required Employee? employee,
    required Customer? customer,
    required ScheduleSituationEnum? situation,
  })  : _id = id ?? "",
        _scheduleDate = scheduleDate ?? DateTime.now(),
        _totalMinutes = totalMinutes ?? 0,
        _totalPrice = totalPrice ?? 0.0,
        _employee = employee ?? Employee.empty(),
        _customer = customer ?? Customer.empty(),
        _situation = situation ?? ScheduleSituationEnum.UNDEFINED;

  factory Schedule.empty() {
    return Schedule(
      id: '',
      scheduleDate: DateTime.now(),
      totalMinutes: 0,
      totalPrice: 0,
      employee: Employee.empty(),
      customer: Customer.empty(),
      situation: ScheduleSituationEnum.UNDEFINED,
    );
  }

  factory Schedule.fromJson(Map data) {
    DateTime scheduleDate = DateTime.parse(data['schedule_date']);
    double totalPrice = double.parse(data['total_price'] ?? '0');
    Employee employee = Employee.fromJson(data['employee']);
    Customer customer = Customer.fromJson(data['customer']);

    return Schedule(
      id: data['id'],
      scheduleDate: scheduleDate,
      totalMinutes: data['total_minutes'],
      totalPrice: totalPrice,
      employee: employee,
      customer: customer,
      situation: ScheduleUtils.fromText(data['situation'] ?? '')[ScheduleFromText.tType],
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

  int get totalMinutes => _totalMinutes;

  set totalMinutes(int value) {
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

  ScheduleSituationEnum get situation => _situation;

  set situation(ScheduleSituationEnum value) {
    _situation = value;
  }
}
