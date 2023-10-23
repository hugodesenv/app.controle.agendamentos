import 'package:agendamentos/models/generic_model.dart';
import 'package:agendamentos/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/schedule_item.dart';
import '../../../utils/constants/widgetsConstantes.dart';
import '../../../widgets/my_modal_search/enum/my_modal_search_enum.dart';
import '../../../widgets/my_modal_search/my_modal_search.dart';
import '../../../widgets/my_text_field.dart';
import '../../../widgets/my_text_title.dart';
import '../bloc/schedule_bloc.dart';
import '../bloc/schedule_event.dart';
import '../bloc/schedule_state.dart';

class ScheduleItems extends StatefulWidget {
  const ScheduleItems({Key? key}) : super(key: key);

  @override
  State<ScheduleItems> createState() => ScheduleItemsState();
}

class ScheduleItemsState extends State<ScheduleItems> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ScheduleBloc>(context);
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, ScheduleState state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTextTitle(title: 'Adicionar itens'),
                  IconButton(
                    icon: const Icon(Icons.post_add_sharp),
                    onPressed: () async {
                      bloc.add(ItemShow());
                      await _modalAddItems();
                    },
                  ),
                ],
              ),
              ...state.schedule.scheduleItem.map(
                (e) {
                  return ListTile(
                    title: Text(
                      e.item.description,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    subtitle: Text(
                        'Preco: ${e.price.toString()} / Tempo: ${e.serviceMinutes.toString()}'),
                    contentPadding: EdgeInsets.zero,
                    onTap: () async {
                      bloc.add(ItemShow(scheduleItem: e));
                      await _modalAddItems();
                    },
                    trailing: IconButton(
                      onPressed: () {
                        bloc.add(ItemDelete(scheduleItem: e));
                      },
                      icon: const Icon(
                        Icons.delete_outlined,
                        color: Colors.black38,
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  'Tempo total: 1h30 / Valor total: R\$129,90',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }

  Future<void> _modalAddItems() async {
    await showModalBottomSheet(
      context: context,
      shape: shapeModalBottomSheet,
      isScrollControlled: true,
      builder: (_) {
        var bloc = BlocProvider.of<ScheduleBloc>(context);
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, ScheduleState state) {
              ScheduleItem item = state.currentItem;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MyTextTitle(
                        title: item.item.description.isEmpty
                            ? 'Adicionar'
                            : 'Alterar',
                        align: TextAlign.center,
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: MyModalSearch(
                          initialValue: item.item.description,
                          typeSearch: MyModalSearchEnum.tItem,
                          onTap: (model) {
                            context.read<ScheduleBloc>().add(ItemChange(model));
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: _inputPrice(),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: _inputMinutes(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            bloc.add(ItemSave());
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.save_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _inputPrice() {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      buildWhen: (previous, current) =>
          previous.currentItem.price != current.currentItem.price,
      builder: (context, state) {
        return MyTextField(
          title: 'Valor',
          initialValue: state.currentItem.price.toString(),
          suffixIcon: const Icon(Icons.monetization_on_outlined),
          onChange: (value) {
            var price = double.tryParse(value) ?? 0.0;
            context.read<ScheduleBloc>().add(ItemPriceChange(price));
          },
        );
      },
    );
  }

  Widget _inputMinutes() {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      buildWhen: (previous, current) =>
          previous.currentItem.serviceMinutes !=
          current.currentItem.serviceMinutes,
      builder: (context, state) {
        return MyTextField(
          title: 'Tempo',
          suffixIcon: const Icon(Icons.timer_sharp),
          initialValue: state.currentItem.serviceMinutes.toString(),
          onChange: (value) {
            var minutes = int.tryParse(value) ?? 0;
            context.read<ScheduleBloc>().add(ItemMinutesChange(minutes));
          },
        );
      },
    );
  }
}
