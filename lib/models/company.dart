import 'package:agendamentos/models/generic_model.dart';

class Company extends GenericModel {
  String _socialName;
  bool _active;

  Company({required String? id, required String? socialName, bool? active})
      : _socialName = socialName ?? '',
        _active = active ?? false,
        super(id: id);

  factory Company.empty() {
    return Company(id: '', socialName: '');
  }

  factory Company.fromJson(Map? json) {
    return Company(
      id: json?['id'],
      socialName: json?['social_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'social_name': socialName,
      'active': active,
    };
  }

  String get socialName => _socialName;

  bool get active => _active;

  set active(bool value) {
    _active = value;
  }

  set socialName(String value) {
    _socialName = value;
  }
}
