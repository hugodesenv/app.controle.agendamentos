/// This component returns a field, when on clicked, the app
/// show a modal with a list of data. When clicked on, is returned
/// the data had been clicked.
/// I don't know english very good...

import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_bloc.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:agendamentos/widgets/my_search_text_field/my_search_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants/colorConstantes.dart';

class MyModalSearch extends StatelessWidget {
  final TextEditingController _fieldController;
  final String _initialID;
  final String _collection;
  final String _columnShow;
  final String _title;
  final Function(String id, Map<String, dynamic> selected) _onSelected;

  MyModalSearch({
    Key? key,
    required Function(String id, Map<String, dynamic> selected) onSelected,
    required String collection,
    required String columnShow,
    required String title,
    required String initialID,
  })  : _onSelected = onSelected,
        _collection = collection,
        _columnShow = columnShow,
        _title = title,
        _initialID = initialID,
        _fieldController = TextEditingController(),
        super(key: key);

  _onTapListTile(BuildContext context, dataSelected) {
    _onSelected(dataSelected.id, dataSelected.data());
    _fieldController.text = dataSelected.get(_columnShow);
    Navigator.pop(context);
  }

  Future _openDialog(BuildContext context, MyModalSearchBloc bloc) async {
    await showDialog(
      context: context,
      builder: (_) {
        return BlocBuilder(
          bloc: bloc,
          builder: (_, state) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList = [];
            if (state is MyModalSearchStateLoaded) {
              dataList.clear();
              dataList.addAll(state.data);
            }
            return AlertDialog(
              title: Row(
                children: [
                  Expanded(child: Text(_title, textAlign: TextAlign.center, style: TextStyle(color: primaryColor(context)))),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: primaryColor(context)),
                  ),
                ],
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: state is MyModalSearchStateLoadingAll
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: MySearchTextField(
                              onChanged: (value) => bloc.add(MyModalSearchEventFilterData(value: value, columnToFilter: _columnShow)),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (_, index) {
                                var dataSelected = dataList[index];
                                return ListTile(
                                  title: Text(dataSelected[_columnShow], style: const TextStyle(fontSize: 15)),
                                  onTap: () => _onTapListTile(context, dataSelected),
                                );
                              },
                              itemCount: dataList.length,
                              separatorBuilder: (_, int index) => const Divider(),
                            ),
                          ),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onTapField(context, bloc) async {
    bloc.add(MyModalSearchEventFetchAll(columnShow: _columnShow, collection: _collection));
    await _openDialog(context, bloc);
  }

  Widget _suffixIcon(bool loading) {
    if (loading) {
      return Transform.scale(
        scale: 0.5,
        child: const CircularProgressIndicator(),
      );
    }
    return const Icon(Icons.search_rounded);
  }

  @override
  Widget build(BuildContext context) {
    final MyModalSearchBloc bloc = MyModalSearchBloc(MyModalSearchStateInitial())
      ..add(MyModalSearchEventFetchByID(
        _columnShow,
        _collection,
        _initialID,
      ));

    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder(
        bloc: bloc,
        builder: (_, state) {
          if (state is MyModalSearchStateLoadedById) {
            _fieldController.text = state.description;
          }
          return GestureDetector(
            onTap: () async => await _onTapField(context, bloc),
            child: TextField(
              controller: _fieldController,
              enabled: false,
              decoration: InputDecoration(suffixIcon: _suffixIcon(state is MyModalSearchStateLoadingById)),
            ),
          );
        },
      ),
    );
  }
}
