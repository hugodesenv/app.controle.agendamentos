import 'package:agendamentos/pages/schedules/schedule_modal_add_items.dart';
import 'package:agendamentos/provider/schedule_provider.dart';
import 'package:agendamentos/utils/datetime_util.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/schedule_item.dart';
import '../../provider/schedule_items_provider.dart';
import '../../utils/constants/widgetsConstantes.dart';
import '../../widgets/my_text_title.dart';

class ScheduleItems extends StatefulWidget {
  const ScheduleItems({Key? key}) : super(key: key);

  @override
  State<ScheduleItems> createState() => ScheduleItemsState();
}

class ScheduleItemsState extends State<ScheduleItems> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            titleBox(),
            ...itemList(context),
            const Divider(),
            labelTotal(context),
            const Divider(),
          ],
        );
      },
    );
  }

  Iterable<ListTile> itemList(BuildContext context) {
    var model = context.read<ScheduleProvider>().schedule.scheduleItem;
    return model.map(
      (item) {
        double leftPadding = 20.0;
        return ListTile(
          title: Padding(
            padding: EdgeInsets.only(left: leftPadding),
            child: Text(
              item.item.description,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(left: leftPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(UtilBrasilFields.obterReal(item.price)),
                Text(
                  "${DateTimeUtil.formatTimeHHMM(Duration(minutes: item.serviceMinutes))}h",
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          onTap: () async => await modalItem(context, scheduleItem: item),
          trailing: IconButton(
            onPressed: () {
              //bloc.add(ItemDelete(scheduleItem: e));
            },
            icon: const Icon(
              Icons.delete_outlined,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget titleBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextTitle(title: 'Adicionar itens'),
        IconButton(
          icon: const Icon(Icons.post_add_sharp),
          onPressed: () async {
            await modalItem(context);
          },
        ),
      ],
    );
  }

  Widget labelTotal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Text(
        context.read<ScheduleProvider>().schedule.getTotalDescription(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Future<void> modalItem(
    BuildContext context, {
    ScheduleItem? scheduleItem,
  }) async {
    await showModalBottomSheet(
      context: context,
      shape: shapeModalBottomSheet,
      isScrollControlled: true,
      builder: (_) {
        return ChangeNotifierProvider(
          create: (_) => ScheduleItemsProvider(),
          builder: (context, _) => ScheduleModalAddItems(
            scheduleItem: scheduleItem,
            onResultItem: (currentItem) {
              context.read<ScheduleProvider>().addItem(currentItem);
            },
          ),
        );
      },
    );
  }
}
