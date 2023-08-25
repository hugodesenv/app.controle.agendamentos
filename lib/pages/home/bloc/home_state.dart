import 'package:agendamentos/model/login.dart';
import 'package:agendamentos/models/account.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeStateSignOut extends HomeState {}

class HomeStateRefreshUser extends HomeState {
  final Account accountConnected;

  HomeStateRefreshUser({required this.accountConnected});
}
