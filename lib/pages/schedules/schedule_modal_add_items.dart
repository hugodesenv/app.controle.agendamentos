import 'package:agendamentos/provider/schedule_items_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/schedule_item.dart';
import '../../widgets/my_modal_search/enum/my_modal_search_enum.dart';
import '../../widgets/my_modal_search/my_modal_search.dart';
import '../../widgets/my_numeric_field.dart';
import '../../widgets/my_text_title.dart';

class ScheduleModalAddItems extends StatefulWidget {
  ScheduleItem? scheduleItem;
  Function(ScheduleItem currentItem) onResultItem;

  ScheduleModalAddItems({
    super.key,
    this.scheduleItem,
    required this.onResultItem,
  });

  @override
  State<ScheduleModalAddItems> createState() => _ScheduleModalAddItemsState();
}

class _ScheduleModalAddItemsState extends State<ScheduleModalAddItems> {
  @override
  void initState() {
    context.read<ScheduleItemsProvider>().scheduleItem = widget.scheduleItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleItemsProvider>(
      builder: (context, provider, _) {
        var title =
            provider.scheduleItem.item.id.isEmpty ? 'Adicionar' : 'Alterar';
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
                  title: title,
                  align: TextAlign.center,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: MyModalSearch(
                    initialValue: provider.scheduleItem.item.description,
                    typeSearch: MyModalSearchEnum.tItem,
                    onTap: (model) => provider.changeItem(model),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: MyNumericField(
                          title: 'Valor',
                          decimalSize: 2,
                          initialValue: provider.scheduleItem.price.toString(),
                          iconData: Icons.attach_money_rounded,
                          onChange: (value) => provider.changeItemPrice(value),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: MyNumericField(
                          title: 'Tempo',
                          iconData: Icons.access_time_sharp,
                          initialValue:
                              provider.scheduleItem.serviceMinutes.toString(),
                          onChange: (value) =>
                              provider.changeItemTimeService(value),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      widget.onResultItem(provider.scheduleItem);
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
    );
  }
}