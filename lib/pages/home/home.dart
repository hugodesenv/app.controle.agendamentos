import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_event.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cardInfo(String pTitle) {
      return SizedBox(
        width: 150.0,
        child: Center(
          child: Card(
            child: ListTile(
              title: Text(
                pTitle,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              subtitle: const Text('R\$150,00', textAlign: TextAlign.center),
            ),
          ),
        ),
      );
    }

    return BlocListener(
      bloc: BlocProvider.of<HomeBloc>(context),
      listener: (context, state) {
        if (state is HomeStateSignOut) {
          Navigator.pushReplacementNamed(context, ROUTE_LOGIN);
        }
      },
      child: BlocBuilder(
        bloc: BlocProvider.of<HomeBloc>(context),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Home")),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          cardInfo('Qtde.'),
                          cardInfo('Total'),
                          cardInfo('Comissão'),
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
                        onPressed: () => BlocProvider.of<HomeBloc>(context).add(HomeEventSignOut()),
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
