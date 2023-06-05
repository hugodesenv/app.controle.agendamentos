/// This component returns a field, when on clicked, the app
/// show a modal with a list of data. When clicked on, is returned
/// the data had been clicked.
/// I don't know english very good...

import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_bloc.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'enum/enumTypeModel.dart';

class MyModalSearch extends StatelessWidget {
  final TypeModal _typeModal;
  final Function(Map<String, dynamic> value) _onSelected;

  const MyModalSearch({Key? key, required TypeModal typeModal, required Function(Map<String, dynamic> value) onSelected})
      : _typeModal = typeModal,
        _onSelected = onSelected,
        super(key: key);

  Future _openDialog(BuildContext context, MyModalSearchBloc bloc) async {
    var title = 'Título indefinido';
    await showDialog(
      context: context,
      builder: (_) {
        return BlocBuilder(
          bloc: bloc,
          builder: (_, state) {
            List<Map<String, dynamic>> dataList = [];
            if (state is MyModalSearchStateLoaded) {
              title = state.title;
              dataList.clear();
              dataList.addAll(state.list);
            }

            return AlertDialog(
              title: Text(title),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: state is MyModalSearchStateLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemBuilder: (_, index) {
                          var data = dataList[index];
                          return ListTile(
                            title: Text(data['value'], style: const TextStyle(fontSize: 15)),
                            onTap: () {
                              bloc.add(MyModalSearchEventTapItem(data: data));
                              Navigator.pop(context);
                            },
                          );
                        },
                        itemCount: dataList.length,
                        separatorBuilder: (_, int index) => const Divider(),
                      ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String labelText = '';
    Map<String, dynamic> currentData = {};
    TextEditingController textController = TextEditingController();
    final MyModalSearchBloc bloc = MyModalSearchBloc(MyModalSearchStateInitial())..add(MyModalSearchEventInitial(typeModal: _typeModal));

    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder(
        bloc: bloc,
        builder: (_, state) {
          if (state is MyModalSearchStateTextTitle) {
            labelText = state.textTitle;
          } else if (state is MyModalSearchStateClickedData) {
            currentData = state.data;
            _onSelected(currentData);
            textController.text = currentData['value'] ?? '';
          }
          return GestureDetector(
            onTap: () async {
              bloc.add(MyModalSearchEventFetchData(typeModal: _typeModal));
              await _openDialog(context, bloc);
            },
            child: TextField(
              controller: textController,
              enabled: false,
              decoration: InputDecoration(
                labelText: labelText,
                suffixIcon: const Icon(Icons.search_rounded),
              ),
            ),
          );
        },
      ),
    );
  }
}
