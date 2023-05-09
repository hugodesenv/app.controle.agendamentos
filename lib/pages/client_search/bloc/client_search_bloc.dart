import 'package:agendamentos/model/client.dart';
import 'package:agendamentos/pages/client_search/bloc/client_search_event.dart';
import 'package:agendamentos/pages/client_search/bloc/client_search_state.dart';
import 'package:bloc/bloc.dart';

class ClientSearchBloc extends Bloc<ClientSearchEvent, ClientSearchState> {
  ClientSearchBloc(super.initialState) {
    on<ClientSearchEventFetchAll>(_fetchAll);
    on<ClientSearchEventTapNew>(_tapNew);
  }

  void _fetchAll(event, emit) {
    List<Client> clients = [];

    emit(ClientSearchStateLoading());
    emit(ClientSearchStateListData(list: clients));
  }

  void _tapNew(event, emit) {
    emit(ClientSearchStateShowOptionsNew());
  }
}
