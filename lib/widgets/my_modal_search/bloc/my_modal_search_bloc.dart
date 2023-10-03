import 'dart:async';

import 'package:agendamentos/repository/api/customer_repository.dart';
import 'package:agendamentos/repository/api/employee_repository.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:agendamentos/widgets/my_modal_search/enum/my_modal_search_enum.dart';
import 'package:bloc/bloc.dart';

import '../model/my_modal_search_values.dart';

class MyModalSearchBloc extends Bloc<MyModalSearchEvent, MyModalSearchState> {
  //late Timer _fetchTimeout;
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
        case MyModalSearchEnum.tCustomer:
          var res = await CustomerRepository.instance.findAll();
          for (var i in res['customers']) {
            originalList.add(MyModalSearchValues(i.id, i.name, i.cellphone));
          }
          break;
        case MyModalSearchEnum.tEmployee:
          var res = await EmployeeRepository.instance.findAll();
          for (var i in res['employee']) {
            originalList.add(MyModalSearchValues(i.id, i.name, 'Clique para selecionar'));
          }
          break;
      }

      emit(MyModalSearchState(values: originalList));
    } catch (e) {
      print("** my_modal_search_bloc catch ${e.toString()}");
    }
  }

  _filterList(MyModalSearchEventChangeFilter event, emit) {
    // ** implementar futuramente a lista aqui...
    /*_fetchTimeout != null ? _fetchTimeout.cancel() : null;

    _fetchTimeout = Timer(const Duration(seconds: 2), () {
      print("** bom, agora deve puxar os dados da api...");
      print("** isso de acordo com o que foi digitado");
      print("** dados a ser buscado ${event.value}");
    });*/

    var filtered = originalList.where((e) {
      String title = e.title.toString().toLowerCase();
      return title.contains(event.value);
    }).toList();

    emit(MyModalSearchState(values: filtered));
  }
}
