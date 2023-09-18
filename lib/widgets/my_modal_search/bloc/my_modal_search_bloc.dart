import 'package:agendamentos/models/customer.dart';
import 'package:agendamentos/repository/api/customer_repository.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:agendamentos/widgets/my_modal_search/enum/my_modal_search_enum.dart';
import 'package:bloc/bloc.dart';

class MyModalSearchBloc extends Bloc<MyModalSearchEvent, MyModalSearchState> {
  MyModalSearchBloc(super.initialState) {
    on<MyModalSearchEventFindAll>(_findAll);
  }

  Future<void> _findAll(MyModalSearchEventFindAll event, emit) async {
    try {
      List<MyModalSearchValues> results = [];
      List values = [];

      switch (event.typeSelection) {
        case MyModalSearchEnum.CUSTOMER:
          var res = await CustomerRepository.instance.findAll();
          values = res['customers'];
          break;
      }

      for (var data in values) {
        if (data is Customer) {
          results.add(MyModalSearchValues(data.id, data.name, data.cellphone));
        }
      }

      emit(MyModalSearchState(values: results));
    } catch (e) {
      print("** my_modal_search_bloc catch ${e.toString()}");
    }
  }
}
