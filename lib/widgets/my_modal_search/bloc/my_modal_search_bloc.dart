import 'dart:async';
import 'package:agendamentos/enum/item_tipo_enum.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:agendamentos/repository/employee_repository.dart';
import 'package:agendamentos/repository/item_repository.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:agendamentos/widgets/my_modal_search/enum/my_modal_search_enum.dart';
import 'package:bloc/bloc.dart';
import '../../../models/item.dart';
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
          for (var customer in res['customers']) {
            originalList.add(
              MyModalSearchValues(
                customer.id,
                customer.name,
                customer.cellphone,
                customer,
              ),
            );
          }
          break;
        case MyModalSearchEnum.tEmployee:
          var res = await EmployeeRepository.instance.findAll();
          for (var employee in res['employee']) {
            originalList.add(
              MyModalSearchValues(
                employee.id,
                employee.name,
                'Clique para selecionar',
                employee,
              ),
            );
          }
          break;
        case MyModalSearchEnum.tItem:
          var res = await ItemRepository.instance.findAll();
          for (Item item in res['items']) {
            originalList.add(
              MyModalSearchValues(
                item.id,
                item.description,
                item.tipo.typeDescription,
                item,
              ),
            );
          }
          break;
      }

      emit(MyModalSearchState(values: originalList));
    } catch (e) {
      print("----> my_modal_search_bloc catch ${e.toString()}");
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
