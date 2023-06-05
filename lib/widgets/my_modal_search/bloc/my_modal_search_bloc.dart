import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:agendamentos/widgets/my_modal_search/enum/enumTypeModel.dart';
import 'package:bloc/bloc.dart';

class MyModalSearchBloc extends Bloc<MyModalSearchEvent, MyModalSearchState> {
  MyModalSearchBloc(super.initialState) {
    on<MyModalSearchEventInitial>(_initial);
    on<MyModalSearchEventFetchData>(_fetchData);
    on<MyModalSearchEventTapItem>(_tapItem);
  }

  void _initial(MyModalSearchEventInitial event, emit) {
    String textTitle = '';
    switch (event.typeModal) {
      case TypeModal.CUSTOMER:
        textTitle = 'Clientes';
        break;
    }
    emit(MyModalSearchStateTextTitle(textTitle: textTitle));
  }

  Future _fetchData(MyModalSearchEventFetchData event, emit) async {
    List<Map<String, dynamic>> data = [];
    String title = '';

    emit(MyModalSearchStateLoading());
    try {
      switch (event.typeModal) {
        case TypeModal.CUSTOMER:
          {
            title = 'Clientes';

            // só pra testar... @@hugo
            Map<String, dynamic> map1 = {"key": "1029u3jn12j3kof2", "value": "Gabriella"};
            data.add(map1);

            Map<String, dynamic> map2 = {"key": "91i23u12j321jnf", "value": "Hugo Silva"};
            data.add(map2);

            break;
          }
      }
    } finally {
      emit(MyModalSearchStateLoaded(title: title, list: data));
    }
  }

  void _tapItem(MyModalSearchEventTapItem event, emit) {
    emit(MyModalSearchStateClickedData(data: event.data));
  }
}
