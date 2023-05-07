import 'package:agendamentos/routes.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, ROUTE_LOGIN);
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person_add_alt),
                onTap: () => Navigator.pushNamed(context, ROUTE_CLIENT),
                title: const Text('Clientes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
