import 'package:agendamentos/repository/api/customer_repository.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:agendamentos/widgets/my_modal_search/enum/my_modal_search_enum.dart';
import 'package:bloc/bloc.dart';

import '../model/my_modal_search_values.dart';

class MyModalSearchBloc extends Bloc<MyModalSearchEvent, MyModalSearchState> {
  List<MyModalSearchValues> originalList = [];

  MyModalSearchBloc(super.initialState) {
    on<MyModalSearchEventFindAll>(_findAll);
    on<MyModalSearchEventChangeFilter>(_filterList);
  }

  Future<void> _findAll(MyModalSearchEventFindAll event, emit) async {
    try {
      if (originalList.isNotEmpty) {
        emit(MyModalSearchState(values: originalList));
        return;
      }

      originalList = [];
      switch (event.typeSelection) {
        case MyModalSearchEnum.CUSTOMER:
          var res = await CustomerRepository.instance.findAll();
          for (var i in res['customers']) {
            originalList.add(MyModalSearchValues(i.id, i.name, i.cellphone));
          }
          break;
      }

      emit(MyModalSearchState(values: originalList));
    } catch (e) {
      print("** my_modal_search_bloc catch ${e.toString()}");
    }
  }

  _filterList(MyModalSearchEventChangeFilter event, emit) {
    var filtered = originalList.where((e) {
      String title = e.title.toString().toLowerCase();
      return title.contains(event.value);
    }).toList();

    emit(MyModalSearchState(values: filtered));
  }
}
