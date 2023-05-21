import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'bloc/home_event.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<HomeBloc>(context);

    Future exitApp() async {
      Dialogs.materialDialog(
        context: context,
        title: 'Deseja sair do app?',
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
            title: Text(
              pTitle,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 6),
              child:
                  Text('R\$1450,00', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
            ),
          ),
        ),
      );
    }

    return BlocListener(
      bloc: bloc,
      listener: (context, state) async {
        if (state is HomeStateSignOut) {
          Navigator.pushReplacementNamed(context, ROUTE_LOGIN);
        }
      },
      child: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Home")),
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
              child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    ListTile(
                      title: const Text("Hugo Silva de Souza"),
                      subtitle: const Text("(19) 9 8961-5184"),
                      leading: IconButton(
                        icon: const Icon(Icons.exit_to_app_outlined),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async => await exitApp(),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      onTap: () => Navigator.pushNamed(context, ROUTE_CUSTOMER_QUERY),
                      title: const Text('Clientes'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.emoji_objects_outlined),
                      onTap: () => print("** desenvolver"),
                      title: const Text('Itens'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_graph_sharp),
                      onTap: () => print("** desenvolver"),
                      title: const Text('Relatórios'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      onTap: () => print("** desenvolver"),
                      title: const Text('Perfil'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
