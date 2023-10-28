import 'package:agendamentos/pages/schedules/schedule.dart';
import 'package:agendamentos/utils/constants.dart';
import 'package:agendamentos/utils/datetime_util.dart';
import 'package:agendamentos/widgets/my_numeric_field.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/schedule_item.dart';
import '../../../utils/constants/widgetsConstantes.dart';
import '../../../widgets/my_modal_search/enum/my_modal_search_enum.dart';
import '../../../widgets/my_modal_search/my_modal_search.dart';
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
          var scheduleModel = state.schedule;
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
              ...scheduleModel.scheduleItem.map(
                (e) {
                  double leftPadding = 20.0;
                  return ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(left: leftPadding),
                      child: Text(
                        e.item.description,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(left: leftPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(UtilBrasilFields.obterReal(e.price)),
                          Text(
                            "${DateTimeUtil.formatTimeHHMM(Duration(minutes: e.serviceMinutes))}h",
                          ),
                        ],
                      ),
                    ),
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
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  scheduleModel.getTotalDescription(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
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
        return MyNumericField(
          title: 'Valor',
          decimalSize: 2,
          initialValue: state.currentItem.price.toString(),
          iconData: Icons.attach_money_rounded,
          onChange: (value) {
            context.read<ScheduleBloc>().add(ItemPriceChange(value));
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
        return MyNumericField(
          title: 'Tempo',
          iconData: Icons.access_time_sharp,
          initialValue: state.currentItem.serviceMinutes.toString(),
          onChange: (value) {
            context.read<ScheduleBloc>().add(ItemMinutesChange(value));
          },
        );
      },
    );
  }
}
