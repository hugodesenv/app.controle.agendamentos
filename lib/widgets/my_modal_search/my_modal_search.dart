import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_event.dart';
import 'package:agendamentos/widgets/my_modal_search/bloc/my_modal_search_state.dart';
import 'package:agendamentos/widgets/my_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_text_title.dart';
import 'bloc/my_modal_search_bloc.dart';
import 'enum/my_modal_search_enum.dart';
import 'model/my_modal_search_values.dart';

// ignore: must_be_immutable
class MyModalSearch extends StatefulWidget {
  late MyModalSearchEnum _typeSearch;
  late Function(dynamic model) _onTap;
  late String _initialValue;

  MyModalSearch({
    Key? key,
    required MyModalSearchEnum typeSearch,
    required Function(dynamic model) onTap,
    String? initialValue,
  }) : super(key: key) {
    _typeSearch = typeSearch;
    _onTap = onTap;
    _initialValue = initialValue ?? '';
  }

  @override
  State<MyModalSearch> createState() => _MyModalSearchState();
}

class _MyModalSearchState extends State<MyModalSearch> {
  late ScrollController _scrollController;
  late TextEditingController _tecValue;

  @override
  void initState() {
    _tecValue = TextEditingController(text: widget._initialValue);
    _settupScroll();
    super.initState();
  }

  /// function to determinate when the page is in the end
  _settupScroll() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _addMoreItems();
      }
    });
  }

  _addMoreItems() {}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                MyTextTitle(
                  title: widget._typeSearch.displayTitle(),
                ),
                TextField(
                  controller: _tecValue,
                  onTap: () async => await _showModal(context),
                  readOnly: true,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search_rounded),
                  ),
                ),
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
          value: BlocProvider.of<MyModalSearchBloc>(context)
            ..add(MyModalSearchEventFindAll(widget._typeSearch)),
          child: BlocBuilder(
            bloc: BlocProvider.of<MyModalSearchBloc>(context),
            builder: (_, MyModalSearchState state) {
              var bloc = BlocProvider.of<MyModalSearchBloc>(context);
              var itemsCount = state.values.length;
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.remove),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: MySearchTextField(
                        onChanged: (value) {
                          bloc.add(
                              MyModalSearchEventChangeFilter(value: value));
                        },
                      ),
                    ),
                    const Divider(),
                    Flexible(
                      child: state.values.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                              controller: _scrollController,
                              separatorBuilder: (_, index) => const Divider(),
                              itemCount: itemsCount + 1,
                              itemBuilder: (_, index) {
                                if (index < itemsCount) {
                                  MyModalSearchValues item =
                                      state.values[index];
                                  return ListTile(
                                    title: Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    subtitle: Text(
                                      item.subtitle,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                    onTap: () {
                                      _tecValue.text = item.title;
                                      widget._onTap(item.model);
                                      Navigator.pop(context);
                                    },
                                  );
                                } /*
                          else {
                            return const Center(
                              child: Text('Buscando informações...'),
                            );
                          }*/
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
