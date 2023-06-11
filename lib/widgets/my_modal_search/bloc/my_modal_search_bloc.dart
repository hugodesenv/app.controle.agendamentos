import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyModalSearchBloc extends Bloc<MyModalSearchEvent, MyModalSearchState> {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs = [];

  MyModalSearchBloc(super.initialState) {
    on<MyModalSearchEventFetchByID>(_fetchById);
    on<MyModalSearchEventFetchAll>(_fetchData);
    on<MyModalSearchEventFilterData>(_filterData);
  }

  void _fetchById(MyModalSearchEventFetchByID event, emit) async {
    emit(MyModalSearchStateLoadingById());

    var collection = FirebaseFirestore.instance.collection(event.collection);
    var snapshot = await collection.doc(event.id).get();
    var description = snapshot.data()![event.columnShow];

    emit(MyModalSearchStateLoadedById(description));
  }

  /// result the list database data
  void _fetchData(MyModalSearchEventFetchAll event, emit) async {
    if (_docs.isEmpty) {
      emit(MyModalSearchStateLoadingAll());

      var collection = FirebaseFirestore.instance.collection(event.collection);
      var data = await collection.orderBy(event.columnShow).get();

      _docs.addAll(data.docs);
    }

    emit(MyModalSearchStateLoaded(_docs));
  }

  /// filter the data in the list
  void _filterData(MyModalSearchEventFilterData event, emit) {
    var docTemp = _docs;
    var column = event.columnToFilter;
    var value = event.value;

    docTemp = docTemp.where((e) {
      var item = e.data()[column].toString().toLowerCase();
      return item.contains(value);
    }).toList();

    emit(MyModalSearchStateLoaded(docTemp));
  }
}
