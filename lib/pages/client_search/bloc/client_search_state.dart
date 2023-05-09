import '../../../model/client.dart';

abstract class ClientSearchState {}

class ClientSearchStateListData extends ClientSearchState {
  List<Client> _list = [];

  ClientSearchStateListData({required List<Client> list}) : _list = list;

  List<Client> get list => _list;
}

class ClientSearchStateLoading extends ClientSearchState {}

class ClientSearchStateShowOptionsNew extends ClientSearchState {}
