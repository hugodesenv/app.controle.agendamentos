import 'package:agendamentos/utils/constants/widgetsConstantes.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_bloc.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'enum/my_modal_search_enum.dart';

class MyModalSearch extends StatelessWidget {
  late MyModalSearchEnum _typeSearch;
  late Function(String id) _onTap;
  late TextEditingController _tecValue;

  MyModalSearch({
    Key? key,
    required MyModalSearchEnum typeSearch,
    required Function(String id) onTap,
    String? initialValue,
  }) : super(key: key) {
    _typeSearch = typeSearch;
    _onTap = onTap;
    _tecValue = TextEditingController(text: initialValue);
  }

  _getTitleCaption() {
    switch (_typeSearch) {
      case MyModalSearchEnum.CUSTOMER:
        return 'Clientes';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyModalSearchBloc(MyModalSearchState())..add(MyModalSearchEventFindAll(_typeSearch)),
      child: Builder(
        builder: (context) => BlocBuilder(
          bloc: BlocProvider.of<MyModalSearchBloc>(context),
          builder: (_, MyModalSearchState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    _getTitleCaption(),
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _tecValue,
                        onTap: () async => await _showModal(context, state.values),
                        readOnly: true,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _showModal(BuildContext context, values) async {
    await showModalBottomSheet(
      context: context,
      shape: shapeModalBottomSheet,
      useSafeArea: true,
      isDismissible: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: values.length > 0
              ? ListView.separated(
                  separatorBuilder: (_, index) => const Divider(),
                  itemCount: values.length,
                  itemBuilder: (_, index) {
                    MyModalSearchValues i = values[index];
                    return ListTile(
                      title: Text(i.title),
                      subtitle: Text(i.subtitle),
                      onTap: () {
                        _onTap(i.id);
                        _tecValue.text = i.title;
                        Navigator.pop(context);
                      },
                    );
                  },
                )
              : const Center(child: Text("Nenhum registro encontrado")),
        );
      },
    );
  }
}
