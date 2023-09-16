import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/pages/schedule/schedule.dart';
import 'package:agendamentos/pages/schedules/calendar/bloc/schedules_bloc.dart';
import 'package:agendamentos/pages/schedules/calendar/bloc/schedules_event.dart';
import 'package:agendamentos/pages/schedules/calendar/bloc/schedules_state.dart';
import 'package:agendamentos/pages/schedules/calendar/model/schedules_model.dart';
import 'package:agendamentos/pages/schedules/calendar/schedule_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../enum/schedule_enum.dart';
import '../../utils/constants/routesConstants.dart';
import '../../utils/constants/widgetsConstantes.dart';
import '../../utils/displayFormatUtils.dart';
import '../../utils/toColorUtils.dart';
import 'bloc/home_event.dart';

class Home extends StatelessWidget {
  final TextEditingController _userNameController;
  final TextEditingController _companyNameController;
  final SchedulesBloc scheduleCalendarBloc = SchedulesBloc(SchedulesState())..add(SchedulesEventLoad());

  Home({Key? key})
      : _userNameController = TextEditingController(text: 'Usuário indefinido'),
        _companyNameController = TextEditingController(text: 'Empresa indefinida'),
        super(key: key);

  Widget _drawerFixed({
    required Function onTap,
    required String textTitle,
    required IconData iconData,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(iconData, color: Theme.of(context).primaryColor),
      onTap: () async => await onTap(),
      title: Text(
        textTitle,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<HomeBloc>(context);
    Future exitApp() async {
      Dialogs.materialDialog(
        context: context,
        title: 'Deseja sair do app?',
        titleStyle: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w700,
        ),
        msgStyle: const TextStyle(color: Colors.black54),
        msg: 'Espero vê-lo novamente! :)',
        actions: [
          IconsButton(
            onPressed: () => bloc.add(HomeEventSignOut()),
            text: 'Sim',
            iconData: Icons.exit_to_app_outlined,
            color: Theme.of(context).primaryColor,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsOutlineButton(
            onPressed: () => Navigator.pop(context),
            text: 'Não',
            iconData: Icons.cancel_outlined,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
        ],
      );
    }

    Widget cardInfo(String title, double? value) {
      return SizedBox(
        width: 150.0,
        child: Center(
          child: ListTile(
            title: Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                (value ?? 0).toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      );
    }

    return BlocListener(
      bloc: bloc,
      listener: (context, HomeState state) async {
        if (state.isLoggedOut) {
          Navigator.pushReplacementNamed(context, routeLogin);
        }
      },
      child: BlocBuilder(
        bloc: bloc,
        builder: (_, HomeState state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
              actions: _getActionsBar(context),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          cardInfo('Pendentes', state.totals[ScheduleSituationEnum.PENDING.text()]),
                          cardInfo('Confirmados', state.totals[ScheduleSituationEnum.CONFIRMED.text()]),
                          cardInfo('Cancelados', state.totals[ScheduleSituationEnum.CANCELED.text()]),
                          cardInfo('Finalizados', state.totals[ScheduleSituationEnum.COMPLETED.text()]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocProvider(
                      create: (_) => SchedulesBloc(SchedulesState())..add(SchedulesEventLoad()),
                      child: ScheduleCalendar(
                        bloc: scheduleCalendarBloc,
                        onTotals: (date, values) => bloc.add(HomeEventsScheduleListener(date, values)),
                        onScheduleClick: (scheduleModule) async {
                          await _showScheduleDetail(context, scheduleModule);
                        },
                        onEmptyClick: (date) async {
                          var arguments = ScheduleParameters(scheduleDate: date);
                          await _showAddSchedule(context, params: arguments);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            drawer: Drawer(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder(
                      bloc: bloc,
                      builder: (_, HomeState state) {
                        final session = state.accountConnected;
                        _userNameController.text = 'Olá, ${session.name}';
                        _companyNameController.text = session.company.socialName;
                        return Container(
                          padding: const EdgeInsets.only(bottom: 10, top: 20, left: 20),
                          child: ListTile(
                            title: Text(
                              _userNameController.text,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              _companyNameController.text,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            leading: IconButton(
                              icon: Icon(
                                Icons.exit_to_app_rounded,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () async => await exitApp(),
                            ),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.person_outline),
                              onTap: () => Navigator.pushNamed(context, routeCustomerQuery),
                              title: const Text('Clientes'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.hardware_outlined),
                              onTap: () => Navigator.pushNamed(context, routeItemQuery),
                              title: const Text('Produtos e serviços'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.auto_graph_sharp),
                              onTap: () async => await Navigator.pushNamed(context, routeReport),
                              title: const Text('Relatórios'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    _drawerFixed(
                      onTap: () async => Navigator.pushNamed(context, routeProfile),
                      textTitle: 'Configurações',
                      iconData: Icons.settings,
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await _showAddSchedule(context);
              },
              child: const Icon(
                Icons.pending_actions,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _getActionsBar(BuildContext context) {
    return [
      IconButton(
        onPressed: () => scheduleCalendarBloc.add(SchedulesEventLoad()),
        icon: const Icon(Icons.refresh),
      ),
    ];
  }

  Future<void> _showAddSchedule(BuildContext context, {ScheduleParameters? params}) async {
    await Navigator.pushNamed(context, routeSchedule, arguments: params);
  }

  _showScheduleDetail(BuildContext context, ScheduleModule scheduleModule) async {
    await showModalBottomSheet(
      context: context,
      shape: shapeModalBottomSheet,
      builder: (context) {
        String situation = scheduleModule.schedule.situation;
        String displaySituation = DisplayFormatUtils.scheduleSituation(situation);
        Color colorSituation = ToColorUtils.scheduleSituation(situation);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      title: Text(
                        displaySituation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: colorSituation,
                        ),
                      ),
                    ),
                  ),
                ),
                PopupMenuButton(
                  padding: const EdgeInsets.only(top: 10.0),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(child: Text("Alterar")),
                      const PopupMenuItem(
                        child: Text(
                          "Excluir",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0, bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_2_outlined),
                      title: const Text("Nome"),
                      subtitle: Text(scheduleModule.schedule.customer.name),
                    ),
                    ListTile(
                      leading: const Icon(Icons.local_phone_outlined),
                      title: const Text("Celular"),
                      subtitle: Text(scheduleModule.schedule.customer.cellphone),
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer_sharp),
                      title: const Text("Tempo total (Minutos)"),
                      subtitle: Text(scheduleModule.schedule.totalMinutes.toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money_rounded),
                      title: const Text("Preço R\$"),
                      subtitle: Text(scheduleModule.schedule.totalPrice.toString()),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
