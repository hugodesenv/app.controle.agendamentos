import 'package:agendamentos/model/arguments/argsCustomerInfo.dart';
import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/routes.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class CustomerQuery extends StatelessWidget {
  final List<Customer> customers;

  CustomerQuery({Key? key})
      : customers = [],
        super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    var bloc = BlocProvider.of<CustomerQueryBloc>(buildContext);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            onPressed: () => bloc.add(CustomerQueryEventFetchAll()),
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Novo'),
                onTap: () async => await Navigator.pushNamed(
                  buildContext,
                  routeCustomerNew,
                ),
              ),
              PopupMenuItem(
                child: const Text('Importar'),
                onTap: () async => await Navigator.pushNamed(
                  buildContext,
                  routeCustomerImport,
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: bloc,
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
                  child: TextField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      labelText: 'Filtrar...',
                    ),
                    onChanged: (value) => bloc.add(CustomerQueryEventOnChangedFilter(value)),
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
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  UtilBrasilFields.obterTelefone(customer.cellphone),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 10),
                                onTap: () => _onTapCustomer(context, customer),
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

  Future _onTapCustomer(BuildContext buildContext, Customer customer) async {
    var args = ArgsCustomerInfo(
      customer: customer,
      customerQueryBloc: BlocProvider.of<CustomerQueryBloc>(buildContext),
    );

    await Navigator.pushNamed(buildContext, routeCustomerInfo, arguments: args);
  }
}
