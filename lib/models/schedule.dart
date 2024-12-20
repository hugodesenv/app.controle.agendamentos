import 'package:agendamentos/models/customer.dart';
import 'package:agendamentos/models/generic_model.dart';
import 'package:agendamentos/models/schedule_item.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enum/schedule_situation_enum.dart';
import '../utils/datetime_util.dart';
import 'employee.dart';

enum ScheduleFromText {
  tDescription,
  tColor,
  tType,
}

class Schedule extends GenericModel {
  DateTime _scheduleDate;
  int _totalMinutes;
  double _totalPrice;
  Customer _customer;
  Employee _employee;
  ScheduleSituationEnum _situation;
  DateTime? _dateChanged;
  List<ScheduleItem>? _scheduleItem;

  Schedule({
    String? id,
    DateTime? scheduleDate,
    int? totalMinutes,
    double? totalPrice,
    Employee? employee,
    Customer? customer,
    ScheduleSituationEnum? situation,
    List<ScheduleItem>? scheduleItem,
    DateTime? dateChanged,
  })  : _scheduleDate = scheduleDate ?? DateTime.now(),
        _totalMinutes = totalMinutes ?? 0,
        _totalPrice = totalPrice ?? 0.0,
        _employee = employee ?? Employee.empty(),
        _customer = customer ?? Customer.empty(),
        _situation = situation ?? ScheduleSituationEnum.UNDEFINED,
        _scheduleItem = scheduleItem ?? [],
        _dateChanged = dateChanged ?? DateTime(1899),
        super(id: id);

  factory Schedule.empty() {
    return Schedule();
  }

  factory Schedule.fromJson(Map data) {
    DateTime scheduleDate = DateTime.parse(data['schedule_date']);

    String sDateChange =
        data['date_changed'] ?? DateTime(1899).toIso8601String();
    DateTime? dateChanged = DateTime.parse(sDateChange);

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
      situation: fromText(data['situation'] ?? '')[ScheduleFromText.tType],
      scheduleItem: [],
      dateChanged: dateChanged,
    );
  }

  Map toMap() {
    Map items = {
      'insert': [],
      'update': [],
      'delete': [],
    };

    for (var data in scheduleItem) {
      String action = data.action.text();
      items[action].add(data.toMap());
    }

    Map res = {
      'action': action.text(),
      'fk_employee': employee.id,
      'fk_customer': customer.id,
      'schedule_date': DateFormat('yyyy-MM-dd HH:mm:ss').format(scheduleDate),
      'situation': situation.text(),
      'items': items,
    };

    return res;
  }

  Schedule copyWith({
    String? id,
    DateTime? scheduleDate,
    int? totalMinutes,
    double? totalPrice,
    Employee? employee,
    Customer? customer,
    ScheduleSituationEnum? situation,
    List<ScheduleItem>? scheduleItem,
    DateTime? dateChanged,
  }) {
    return Schedule(
      customer: customer ?? this.customer,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      situation: situation ?? this.situation,
      scheduleItem: scheduleItem ?? this.scheduleItem,
      id: id ?? this.id,
      dateChanged: DateTime.now(),
      employee: employee ?? this.employee,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  void removeItem(ScheduleItem item) {
    if (item.action == ActionAPI.tInsert) {
      scheduleItem.remove(item);
      calculateTotal();
      return;
    }

    int index = scheduleItem.indexOf(item);
    scheduleItem[index].action = ActionAPI.tDeleted;
  }

  List<ScheduleItem> filterItems(ActionAPI action, bool isEquals) {
    if (isEquals) {
      return scheduleItem.where((element) => element.action == action).toList();
    } else {
      return scheduleItem.where((element) => element.action != action).toList();
    }
  }

  void saveItem(ScheduleItem item) {
    int index = scheduleItem.indexOf(item);

    if (index == -1) {
      scheduleItem.add(item);
    } else {
      scheduleItem[index] = item;
    }
    calculateTotal();
  }

  void calculateTotal() {
    double price = 0.00;
    int minutes = 0;

    for (var data in scheduleItem) {
      price += data.price;
      minutes += data.serviceMinutes;
    }

    totalPrice = price;
    totalMinutes = minutes;
  }

  static Map<ScheduleFromText, dynamic> fromText(String situation) {
    if (situation == ScheduleSituationEnum.PENDING.text()) {
      return {
        ScheduleFromText.tDescription: 'Pendente',
        ScheduleFromText.tColor: const Color.fromARGB(255, 145, 145, 145),
        ScheduleFromText.tType: ScheduleSituationEnum.PENDING,
      };
    } else if (situation == ScheduleSituationEnum.CANCELED.text()) {
      return {
        ScheduleFromText.tDescription: 'Cancelado',
        ScheduleFromText.tColor: Colors.red,
        ScheduleFromText.tType: ScheduleSituationEnum.CANCELED,
      };
    } else if (situation == ScheduleSituationEnum.CONFIRMED.text()) {
      return {
        ScheduleFromText.tDescription: 'Confirmado',
        ScheduleFromText.tColor: const Color.fromARGB(255, 190, 30, 211),
        ScheduleFromText.tType: ScheduleSituationEnum.CONFIRMED,
      };
    } else if (situation == ScheduleSituationEnum.PROGRESS.text()) {
      return {
        ScheduleFromText.tDescription: 'Em andamento',
        ScheduleFromText.tColor: const Color.fromARGB(255, 106, 186, 240),
        ScheduleFromText.tType: ScheduleSituationEnum.PROGRESS,
      };
    } else if (situation == ScheduleSituationEnum.COMPLETED.text()) {
      return {
        ScheduleFromText.tDescription: 'Finalizado',
        ScheduleFromText.tColor: Colors.green,
        ScheduleFromText.tType: ScheduleSituationEnum.COMPLETED,
      };
    } else {
      return {
        ScheduleFromText.tDescription: 'Indefinido',
        ScheduleFromText.tColor: const Color.fromARGB(255, 0, 0, 0),
        ScheduleFromText.tType: ScheduleSituationEnum.UNDEFINED,
      };
    }
  }

  String getTotalDescription() {
    var time = DateTimeUtil.formatTimeHHMM(Duration(minutes: totalMinutes));
    var total = UtilBrasilFields.obterReal(totalPrice);

    return 'Tempo: ${time}h / Total: $total';
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

  Employee get employee => _employee;

  set employee(Employee value) {
    _employee = value;
  }

  ScheduleSituationEnum get situation => _situation;

  set situation(ScheduleSituationEnum value) {
    _situation = value;
  }

  List<ScheduleItem> get scheduleItem => _scheduleItem ?? [];

  set scheduleItem(List<ScheduleItem> value) {
    _scheduleItem = value;
  }

  DateTime get dateChanged => _dateChanged ?? DateTime(1899);

  set dateChanged(DateTime value) {
    _dateChanged = value;
  }
}
