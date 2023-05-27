import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/arguments/args_customer_new.dart';
import '../query/bloc/customer_query_event.dart';
import 'bloc/customer_new_bloc.dart';

class CustomerNew extends StatelessWidget {
  final ArgsCustomerNew arguments;

  const CustomerNew({Key? key, required this.arguments}) : super(key: key);

  SizedBox spaceHeight() {
    return const SizedBox(height: 14);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController cellphoneController = TextEditingController();

    var bloc = BlocProvider.of<CustomerNewBloc>(context);
    bloc.customer = arguments.customer;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo cliente'),
        actions: [
          IconButton(
            onPressed: () => bloc.add(CustomerNewEventSubmitted()),
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: BlocListener(
        bloc: bloc,
        listener: (_, state) {
          if (state is CustomerNewStateSuccess) {
            arguments.queryBloc.add(CustomerQueryEventAddToList(state.customer));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
            return;
          }
          if (state is CustomerNewStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            return;
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (_, state) {
            Customer customer = bloc.getCustomer;
            switch (state.runtimeType) {
              case CustomerNewStateLoaded:
                nameController.text = customer.name;
                cellphoneController.text = customer.cellphone;
                break;
            }
            return Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).highlightColor,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: bloc.formKeyMain,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Nome'),
                        controller: nameController,
                        onChanged: (value) => bloc.add(CustomerNewEventOnChanged(name: value)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nao pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                      spaceHeight(),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Celular'),
                        controller: cellphoneController,
                        onChanged: (value) => bloc.add(CustomerNewEventOnChanged(cellphone: value)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nao pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
