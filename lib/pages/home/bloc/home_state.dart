import 'package:agendamentos/model/login.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeStateSignOut extends HomeState {}

class HomeStateRefreshUser extends HomeState {
  final Login login;

  HomeStateRefreshUser({required this.login});
}
