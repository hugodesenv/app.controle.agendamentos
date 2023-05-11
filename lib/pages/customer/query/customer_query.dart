import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerQuery extends StatelessWidget {
  const CustomerQuery({Key? key}) : super(key: key);

  Future showBottomModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              ListTile(
                title: const Text("Cadastrar manualmente",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                leading: const Icon(Icons.person_add_alt_1_outlined),
                onTap: () {
                  print("Chamar a tela do cadastro do usuario");
                },
              ),
              ListTile(
                title: const Text("Importar dos contatos",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                leading: const Icon(Icons.contact_mail_outlined),
                onTap: () {
                  print("Chamar a tela para importar os dados");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.person_add_alt),
          ),
        ],
      ),
      body: BlocListener(
        bloc: BlocProvider.of<CustomerQueryBloc>(context),
        listener: (context, state) async {},
        child: BlocBuilder(
          bloc: BlocProvider.of<CustomerQueryBloc>(context),
          builder: (context, state) {
            if (state is CustomerQueryStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CustomerQueryStateLoaded) {
              List<Customer> customers = state.customers;
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  Customer customer = customers[index];
                  String initialLetter = customer.name.substring(0, 1).toUpperCase();

                  Widget customerListTile = ListTile(
                    title: Text(customer.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text(customer.cellphone),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 10),
                    onTap: () {},
                  );

                  if (index == 0 ||
                      customers[index - 1].name.substring(0, 1).toUpperCase() != initialLetter) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          //color: const Color(0xFFFCFCFC),
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
              );
            }

            return const Center(child: Text("Nenhum registro encontrado"));
          },
        ),
      ),
    );
  }
}
