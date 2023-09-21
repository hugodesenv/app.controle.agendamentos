import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_bloc.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:agendamentos/widgets/my_search_text_field/my_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'enum/my_modal_search_enum.dart';
import 'model/my_modal_search_values.dart';

class MyModalSearch extends StatefulWidget {
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

  @override
  State<MyModalSearch> createState() => _MyModalSearchState();
}

class _MyModalSearchState extends State<MyModalSearch> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyModalSearchBloc(MyModalSearchState()),
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
                    widget._typeSearch.displayTitle(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget._tecValue,
                        onTap: () async => await _showModal(context),
                        readOnly: true,
                      ),
                    ),
                    IconButton(
                      onPressed: () async => await _showModal(context),
                      icon: const Icon(Icons.search_rounded),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _showModal(context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<MyModalSearchBloc>(context)..add(MyModalSearchEventFindAll(widget._typeSearch)),
          child: BlocBuilder(
            bloc: BlocProvider.of<MyModalSearchBloc>(context),
            builder: (_, MyModalSearchState state) {
              var bloc = BlocProvider.of<MyModalSearchBloc>(context);
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.remove),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: MySearchTextField(
                        onChanged: (value) => bloc.add(MyModalSearchEventChangeFilter(value: value)),
                      ),
                    ),
                    const Divider(),
                    state.values.isEmpty
                        ? const Center(heightFactor: 1, child: Text('Ops... Nada encontrado!'))
                        : Flexible(
                            child: ListView.separated(
                              separatorBuilder: (_, index) => const Divider(),
                              itemCount: state.values.length,
                              itemBuilder: (_, index) {
                                MyModalSearchValues i = state.values[index];
                                return ListTile(
                                  title: Text(
                                    i.title,
                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Text(i.subtitle),
                                  onTap: () {
                                    widget._onTap(i.id);
                                    widget._tecValue.text = i.title;
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
