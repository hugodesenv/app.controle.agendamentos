import 'package:agendamentos/assets/EnumTypeOpenCustomerQuery.dart';
import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:agendamentos/pages/customer/info/customer_info.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class CustomerQuery extends StatelessWidget {
  const CustomerQuery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CustomerQueryBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Novo'),
                onTap: () => bloc.add(CustomerQueryEventOpen(TypeOpen.tpNew)),
              ),
              PopupMenuItem(
                child: const Text('Importar'),
                onTap: () => bloc.add(CustomerQueryEventOpen(TypeOpen.tpImport)),
              ),
            ],
          ),
        ],
      ),
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) async {
          if (state is CustomerQueryStateOpen) {
            switch (state.typeOpen) {
              case TypeOpen.tpImport:
                await Navigator.pushNamed(context, ROUTE_CUSTOMER_IMPORT);
                break;
              case TypeOpen.tpNew:
                await Navigator.pushNamed(
                  context,
                  ROUTE_CUSTOMER_NEW,
                  arguments: (Customer customer) {
                    print("** novo adicionado");
                    print(customer.name);
                  },
                );
                break;
            }
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            bool isLoading = state is CustomerQueryStateLoading && state.busy;
            return Skeleton(
              isLoading: isLoading,
              skeleton: SkeletonListView(padding: const EdgeInsets.fromLTRB(16, 5, 16, 16)),
              child: bloc.customers.isEmpty
                  ? const Center(child: Text('Nenhum registro encontrado'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        Customer customer = bloc.customers[index];
                        String initialLetter = customer.name.substring(0, 1).toUpperCase();
                        Widget customerListTile = ListTile(
                          title: Text(customer.name,
                              style: const TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text(customer.cellphone),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 10),
                          onTap: () async => await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return BlocProvider(
                                  create: (context) =>
                                      CustomerInfoBloc(CustomerInfoStateInitial(), customer),
                                  child: CustomerInfo(
                                    onDelete: () {
                                      bloc.add(CustomerQueryEventRemoveFromList(customer));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                        if (index == 0 ||
                            bloc.customers[index - 1].name.substring(0, 1).toUpperCase() !=
                                initialLetter) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                color: const Color(0xFFF7F7F7),
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 16),
                                child: Text(
                                  initialLetter,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              customerListTile
                            ],
                          );
                        }
                        return customerListTile;
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: bloc.customers.length,
                    ),
            );
          },
        ),
      ),
    );
  }
}
