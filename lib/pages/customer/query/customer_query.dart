import 'package:agendamentos/model/customer.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Novo'),
                onTap: () => BlocProvider.of<CustomerQueryBloc>(context)..add(CustomerQueryEventNew()),
              ),
              PopupMenuItem(
                child: const Text('Importar'),
                onTap: () => BlocProvider.of<CustomerQueryBloc>(context)..add(CustomerQueryEventImport()),
              ),
            ],
          ),
        ],
      ),
      body: BlocListener(
        bloc: BlocProvider.of<CustomerQueryBloc>(context),
        listener: (context, state) {
          if (state is CustomerQueryStateOpenNew) {
            Navigator.pushNamed(context, ROUTE_CUSTOMER_NEW);
          } else if (state is CustomerQueryStateOpenImport) {
            Navigator.pushNamed(context, ROUTE_CUSTOMER_IMPORT);
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<CustomerQueryBloc>(context),
          builder: (context, state) {
            List<Customer> customers = (state is CustomerQueryStateLoaded) ? state.customers : [];
            bool isLoading = state is CustomerQueryStateLoading;
            return Skeleton(
              isLoading: isLoading,
              skeleton: SkeletonListView(padding: const EdgeInsets.fromLTRB(16, 5, 16, 16)),
              child: customers.isEmpty
                  ? const Center(child: Text("Nenhum registro encontrado"))
                  : ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        Customer customer = customers[index];
                        String initialLetter = customer.name.substring(0, 1).toUpperCase();
                        Widget customerListTile = ListTile(
                          title: Text(customer.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text(customer.cellphone),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 10),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CustomerInfo(customer: customer)),
                          ),
                        );

                        if (index == 0 || customers[index - 1].name.substring(0, 1).toUpperCase() != initialLetter) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 16),
                                  child: Text(
                                    initialLetter,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
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
                      itemCount: customers.length,
                    ),
            );
          },
        ),
      ),
    );
  }
}
