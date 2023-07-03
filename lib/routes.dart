import 'package:agendamentos/model/customer.dart';
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
import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_event.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/pages/item/query/bloc/item_bloc.dart';
import 'package:agendamentos/pages/item/query/bloc/item_event.dart';
import 'package:agendamentos/pages/item/query/bloc/item_state.dart';
import 'package:agendamentos/pages/item/query/item_query.dart';
import 'package:agendamentos/pages/profile/profile.dart';
import 'package:agendamentos/pages/report/report.dart';
import 'package:agendamentos/pages/schedule/schedule.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:agendamentos/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'assets/enum/form_submission_status.dart';
import 'assets/routesConstants.dart';
import 'pages/home/home.dart';

appRoutes(RouteSettings settings) {
  if (settings.name == routeHome) {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (_) => HomeBloc(HomeInitial())..add(HomeEventInitial()),
          child: Home(),
        );
      },
    );
  }

  if (settings.name == routeLogin) {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (_) => SignInBloc(SignInStateInitial())..add(SignInEventAuthenticated()),
          child: const SignIn(),
        );
      },
    );
  }

  if (settings.name == routeCustomerQuery) {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (_) => CustomerQueryBloc(CustomerQueryStateLoading(true))..add(CustomerQueryEventFetchAll()),
          child: CustomerQuery(),
        );
      },
    );
  }

  if (settings.name == routeCustomerNew) {
    var customer = settings.arguments != null ? settings.arguments as Customer : Customer.empty();
    var customerNewState = CustomerNewState(
      id: customer.id,
      name: NameFormz.dirty(value: customer.name),
      cellphone: CellphoneFormz.dirty(value: customer.cellphone),
      status: FormSubmissionStatus.initial,
    );

    return MaterialPageRoute(builder: (_) {
      return BlocProvider(
        create: (_) => CustomerNewBloc(customerNewState),
        child: const CustomerNew(),
      );
    });
  }

  if (settings.name == routeCustomerImport) {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (_) => CustomerImportBloc(CustomerImportStateInitial())..add(CustomerImportEventFetchAll()),
          child: const CustomerImport(),
        );
      },
    );
  }

  if (settings.name == routeCustomerInfo) {
    var args = settings.arguments as Customer;
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => CustomerInfoBloc(CustomerInfoState(customer: args)),
        child: const CustomerInfo(),
      ),
    );
  }

  if (settings.name == routeItemQuery) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => ItemBloc(ItemStateInitial())..add(ItemEventFetchAll()),
        child: ItemQuery(),
      ),
    );
  }

  if (settings.name == routeProfile) {
    return MaterialPageRoute(
      builder: (_) => const Profile(),
    );
  }

  if (settings.name == routeReport) {
    return MaterialPageRoute(
      builder: (_) => const Report(),
    );
  }

  if (settings.name == routeSchedule) {
    return MaterialPageRoute(
      builder: (_) => const Schedule(),
    );
  }
}
