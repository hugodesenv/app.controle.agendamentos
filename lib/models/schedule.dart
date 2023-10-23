import 'package:agendamentos/models/customer.dart';
import 'package:agendamentos/models/generic_model.dart';
import 'package:agendamentos/models/schedule_item.dart';
import 'package:agendamentos/utils/api/schedule_utils.dart';
import 'package:intl/intl.dart';
import 'employee.dart';

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
    return Schedule(
      id: '',
      scheduleDate: DateTime.now(),
      totalMinutes: 0,
      totalPrice: 0,
      employee: Employee.empty(),
      customer: Customer.empty(),
      situation: ScheduleSituationEnum.UNDEFINED,
      scheduleItem: [],
      dateChanged: DateTime.now(),
    );
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
      situation: ScheduleUtils.fromText(
          data['situation'] ?? '')[ScheduleFromText.tType],
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
    );
  }

  void removeItem(ScheduleItem item) {
    if (item.action == ActionAPI.tInsert) {
      scheduleItem.remove(item);
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

  void modifyItem(ScheduleItem item) {
    int index = scheduleItem.indexOf(item);

    if (index == -1) {
      scheduleItem.add(item);
    } else {
      scheduleItem[index] = item;
    }
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
