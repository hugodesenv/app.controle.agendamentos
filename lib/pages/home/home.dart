import 'package:agendamentos/enum/schedule_situation_enum.dart';
import 'package:agendamentos/pages/schedules/calendar/model/schedules_model.dart';
import 'package:agendamentos/pages/schedules/schedule.dart';
import 'package:agendamentos/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

import '../../models/schedule.dart' as ScheduleModel;
import '../../models/schedule.dart';
import '../../utils/constants/constants.dart';
import '../../utils/constants/widgetsConstantes.dart';
import '../schedules/calendar/schedule_calendar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _userNameController;
  late TextEditingController _companyNameController;
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _companyNameController = TextEditingController();

    Future.delayed(Duration.zero).then((value) {
      homeProvider.checkUserLogin();
      homeProvider.findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: appBar(context),
      body: body(),
      drawer: leftDrawer(),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          cardsInfos(),
          widgetSchedule(),
        ],
      ),
    );
  }

  Widget cardsInfos() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SizedBox(
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            /*cardInfo('Pendentes',
                        state.totals[ScheduleSituationEnum.PENDING.text()]),
                    cardInfo('Confirmados',
                        state.totals[ScheduleSituationEnum.CONFIRMED.text()]),
                    cardInfo('Cancelados',
                        state.totals[ScheduleSituationEnum.CANCELED.text()]),
                    cardInfo('Finalizados',
                        state.totals[ScheduleSituationEnum.COMPLETED.text()]),*/
          ],
        ),
      ),
    );
  }

  // componente que mostra todos os agendamentos na pagina inicial
  Widget widgetSchedule() {
    return Expanded(
      child: ScheduleCalendar(
        onTotals: (date, values) {},
        onScheduleClick: (scheduleModule) async {
          await _showScheduleDetail(context, scheduleModule);
        },
        onEmptyClick: (date) async {
          var arguments = ScheduleParameters(scheduleDate: date);
          await _showAddSchedule(context, params: arguments);
        },
        schedules: homeProvider.schedules,
      ),
    );
  }

  Widget leftDrawer() {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<HomeProvider>(
              builder: (context, provider, _) {
                final session = provider.accountConnected;
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
                      onTap: () => Navigator.pushNamed(
                          context, RoutesConstants.routeCustomerQuery),
                      title: const Text('Clientes'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.hardware_outlined),
                      onTap: () => Navigator.pushNamed(
                          context, RoutesConstants.routeItemQuery),
                      title: const Text('Produtos e serviços'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_graph_sharp),
                      onTap: () async => await Navigator.pushNamed(
                          context, RoutesConstants.routeReport),
                      title: const Text('Relatórios'),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            _drawerFixed(
              onTap: () async => Navigator.pushNamed(
                context,
                RoutesConstants.routeProfile,
              ),
              textTitle: 'Configurações',
              iconData: Icons.settings,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Home"),
      actions: [
        PopupMenuButton(
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Atualizar'),
                ),
                onTap: () =>
                    {}, //scheduleCalendarBloc.add(SchedulesEventLoad()),
              ),
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.pending_actions),
                  title: Text('Incluir'),
                ),
                onTap: () async {
                  //When a pop up menu is clicked, it will call pop() on the navigator to dismiss itself.
                  //So pushing an extra route would cause it to pop that route immediately, instead of dismissing itself.
                  await Future.delayed(Duration.zero).then((_) async {
                    await _showAddSchedule(context);
                  });
                },
              ),
            ];
          },
        ),
      ],
    );
  }

  // calling the screem, passing the parameters
  Future<void> _showAddSchedule(
    BuildContext context, {
    ScheduleParameters? params,
  }) async {
    await Navigator.pushNamed(
      context,
      RoutesConstants.routeSchedule,
      arguments: params,
    );
  }

  // click on detail
  _showScheduleDetail(
      BuildContext context, ScheduleModule scheduleModule) async {
    await showModalBottomSheet(
      context: context,
      shape: shapeModalBottomSheet,
      builder: (context) {
        String typeSituation = scheduleModule.schedule.situation.text();
        var res = ScheduleModel.Schedule.fromText(typeSituation);
        String displaySituation = res[ScheduleFromText.tDescription];
        Color colorSituation = res[ScheduleFromText.tColor];
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
                          fontSize: 16.0,
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
                padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 0,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
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
                      subtitle:
                          Text(scheduleModule.schedule.customer.cellphone),
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer_sharp),
                      title: const Text("Tempo total (Minutos)"),
                      subtitle:
                          Text(scheduleModule.schedule.totalMinutes.toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money_rounded),
                      title: const Text("Preço R\$"),
                      subtitle:
                          Text(scheduleModule.schedule.totalPrice.toString()),
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

  // sidebar
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
          onPressed: () async {
            bool res = await homeProvider.logOut();
            if (res) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
          },
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
            style: const TextStyle(fontWeight: FontWeight.w600),
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
}
