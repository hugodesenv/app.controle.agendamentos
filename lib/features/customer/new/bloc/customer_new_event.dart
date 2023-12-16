import 'package:equatable/equatable.dart';

class CustomerNewEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CustomerNewEventNameChanged extends CustomerNewEvent {
  final String name;

  CustomerNewEventNameChanged(this.name);
}

class CustomerNewEventCellphoneChanged extends CustomerNewEvent {
  final String cellphone;

  CustomerNewEventCellphoneChanged(this.cellphone);
}

class CustomerNewEventSubmitted extends CustomerNewEvent {}
