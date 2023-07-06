import 'package:agendamentos/pages/item/bloc/item_query_event.dart';
import 'package:agendamentos/pages/item/bloc/item_query_state.dart';
import 'package:bloc/bloc.dart';

class ItemQueryBloc extends Bloc<ItemQueryEvent, ItemQueryState> {
  ItemQueryBloc(super.initialState) {}
}
