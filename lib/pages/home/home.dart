import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../assets/constants/routesConstants.dart';
import 'bloc/home_event.dart';

class Home extends StatelessWidget {
  final TextEditingController _userNameController;
  final TextEditingController _companyNameController;

  Home({Key? key})
      : _userNameController = TextEditingController(text: 'Usuário indefinido'),
        _companyNameController = TextEditingController(text: 'Empresa indefinida'),
        super(key: key);

  /// fixed widget at the end of drawer
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

    Widget cardInfo(String pTitle) {
      return SizedBox(
        width: 150.0,
        child: Center(
          child: ListTile(
            onTap: () => Navigator.pushNamed(context, routeCustomerNew),
            title: Text(
              pTitle,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text('R\$1450,00', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
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
        builder: (context, state) {
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
                          cardInfo('Atendidos'),
                          cardInfo('Desmarcados'),
                          cardInfo('R\$ Recebido'),
                          cardInfo('R\$ Previsto'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SfCalendar(
                      todayHighlightColor: Theme.of(context).primaryColor,
                      allowedViews: const [
                        CalendarView.day,
                        CalendarView.month,
                        CalendarView.schedule,
                        CalendarView.timelineDay,
                        CalendarView.timelineMonth,
                        CalendarView.timelineWeek,
                        CalendarView.timelineWorkWeek,
                        CalendarView.week,
                        CalendarView.workWeek,
                      ],
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
                await Navigator.pushNamed(context, routeSchedule);
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
    var bloc = BlocProvider.of<HomeBloc>(context);
    return [
      IconButton(
        onPressed: () {
          bloc.add(HomeEventFindSchedules());
        },
        icon: const Icon(Icons.refresh),
      ),
    ];
  }
}
