import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyModalSearchBloc extends Bloc<MyModalSearchEvent, MyModalSearchState> {
  MyModalSearchBloc(super.initialState) {
    on<MyModalSearchEventFetchByID>(_fetchById);
    on<MyModalSearchEventFetchAll>(_fetchData);
  }

  void _fetchById(MyModalSearchEventFetchByID event, emit) async {
    emit(MyModalSearchStateLoadingById());

    var collection = FirebaseFirestore.instance.collection(event.collection);
    var snapshot = await collection.doc(event.id).get();
    var description = snapshot.data()![event.columnShow];

    emit(MyModalSearchStateLoadedById(description));
  }

  void _fetchData(MyModalSearchEventFetchAll event, emit) async {
    emit(MyModalSearchStateLoadingAll());

    var collection = FirebaseFirestore.instance.collection(event.collection);
    var data = await collection.orderBy(event.columnShow).get();

    emit(MyModalSearchStateLoaded(data.docs));
  }
}
