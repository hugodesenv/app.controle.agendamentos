import 'package:agendamentos/models/customer.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_bloc.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_event.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_state.dart';
import 'package:agendamentos/pages/customer/import/customer_import.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:agendamentos/pages/customer/info/customer_info.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_bloc.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/pages/customer/new/customer_new.dart';
import 'package:agendamentos/pages/customer/new/formz/model.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/pages/customer/query/customer_query.dart';
import 'package:agendamentos/pages/item/bloc/item_query_bloc.dart';
import 'package:agendamentos/pages/item/bloc/item_query_state.dart';
import 'package:agendamentos/pages/item/item_query.dart';
import 'package:agendamentos/pages/profile/profile.dart';
import 'package:agendamentos/pages/report/report.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_bloc.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_state.dart';
import 'package:agendamentos/pages/schedules/schedule.dart';
import 'package:agendamentos/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home/home.dart';

appRoutes(RouteSettings settings) {
  if (settings.name == RoutesConstants.routeHome) {
    return MaterialPageRoute(builder: (_) => Home());
  } else if (settings.name == RoutesConstants.routeCustomerQuery) {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (_) => CustomerQueryBloc(CustomerQueryStateLoading(true))
            ..add(CustomerQueryEventFetchAll()),
          child: CustomerQuery(),
        );
      },
    );
  } else if (settings.name == RoutesConstants.routeCustomerNew) {
    var customer = settings.arguments as Customer;

    var customerState = CustomerNewState(
      name: NameFormz.dirty(value: customer.name),
      cellphone: CellphoneFormz.dirty(value: customer.cellphone),
    );

    return MaterialPageRoute(builder: (_) {
      return BlocProvider(
        create: (_) => CustomerNewBloc(customer, customerState),
        child: const CustomerNew(),
      );
    });
  } else if (settings.name == RoutesConstants.routeCustomerImport) {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (_) => CustomerImportBloc(CustomerImportStateInitial())
            ..add(CustomerImportEventFetchAll()),
          child: const CustomerImport(),
        );
      },
    );
  } else if (settings.name == RoutesConstants.routeCustomerInfo) {
    var args = settings.arguments as Customer;
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => CustomerInfoBloc(CustomerInfoState(customer: args)),
        child: CustomerInfo(),
      ),
    );
  } else if (settings.name == RoutesConstants.routeProfile) {
    return MaterialPageRoute(
      builder: (_) => const Profile(),
    );
  } else if (settings.name == RoutesConstants.routeReport) {
    return MaterialPageRoute(
      builder: (_) => const Report(),
    );
  } else if (settings.name == RoutesConstants.routeSchedule) {
    // ScheduleParameters? arguments = settings.arguments as ScheduleParameters?;
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => ScheduleBloc(ScheduleState()),
        child: Schedule(),
      ),
    );
  } else if (settings.name == RoutesConstants.routeItemQuery) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => ItemQueryBloc(ItemQueryStateInitial()),
        child: const ItemQuery(),
      ),
    );
  }
}
