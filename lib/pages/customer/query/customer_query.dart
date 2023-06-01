import 'package:agendamentos/assets/utilsConstantes.dart';
import 'package:agendamentos/model/arguments/args_customer_info.dart';
import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/widgets/text_field/my_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

import '../../../assets/routesConstants.dart';
import '../../../model/arguments/args_customer_new.dart';
import 'bloc/customer_query_bloc.dart';
import 'bloc/customer_query_event.dart';
import 'bloc/customer_query_state.dart';

class CustomerQuery extends StatelessWidget {
  final List<Customer> customers;

  CustomerQuery({Key? key})
      : customers = [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var blocQuery = BlocProvider.of<CustomerQueryBloc>(context);

    Future onTapCustomer(int index) async {
      var args = ArgsCustomerInfo(customer: customers[index]);
      await Navigator.pushNamed(context, routeCustomerInfo, arguments: args);
      blocQuery.add(CustomerQueryEventFetchAll());
    }

    Future onTapNew() async {
      await Future.delayed(zeroDuration, () async {
        var args = ArgsCustomerNew.query(queryBloc: blocQuery);
        await Navigator.pushNamed(context, routeCustomerNew, arguments: args);
        blocQuery.add(CustomerQueryEventFetchAll());
      });
    }

    Future onTapImport() async {
      await Future.delayed(zeroDuration, () async {
        await Navigator.pushNamed(context, routeCustomerImport);
        blocQuery.add(CustomerQueryEventFetchAll());
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            onPressed: () => blocQuery.add(CustomerQueryEventFetchAll()),
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Novo'),
                onTap: () async => await onTapNew(),
              ),
              PopupMenuItem(
                child: const Text('Importar'),
                onTap: () async => await onTapImport(),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: blocQuery,
        builder: (context, state) {
          bool isLoading = state is CustomerQueryStateLoading && state.busy;
          if (state is CustomerQueryStateRefreshList) {
            customers.clear();
            customers.addAll(state.customers);
            customers.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
          }
          return Skeleton(
            isLoading: isLoading,
            skeleton: SkeletonListView(padding: const EdgeInsets.fromLTRB(16, 5, 16, 16)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 20),
                  child: MySearchTextField(
                    onChanged: (value) => blocQuery.add(CustomerQueryEventOnChangedFilter(value)),
                  ),
                ),
                customers.isEmpty
                    ? const Center(child: Text('Nenhum registro encontrado'))
                    : Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              Customer customer = customers[index];
                              String initialLetter = customer.name.substring(0, 1).toUpperCase();
                              Widget customerListTile = ListTile(
                                title: Text(
                                  customer.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Text(
                                  customer.cellphone,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 10),
                                onTap: () async => await onTapCustomer(index),
                              );
                              if (index == 0 || customers[index - 1].name.substring(0, 1).toUpperCase() != initialLetter) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                        color: Color(0xFFF7F7F7),
                                      ),
                                      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 16),
                                      child: Text(
                                        initialLetter,
                                        style: const TextStyle(color: Colors.black26, fontSize: 10),
                                      ),
                                    ),
                                    customerListTile
                                  ],
                                );
                              }
                              return customerListTile;
                            },
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: customers.length,
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
