import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/customer_new_bloc.dart';

class CustomerNew extends StatelessWidget {
  const CustomerNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("** antes dos controladores");
    TextEditingController nameController = TextEditingController();
    TextEditingController cellphoneController = TextEditingController();

    print("** antes do bloc");
    var bloc = BlocProvider.of<CustomerNewBloc>(context);
    print("** dps do bloc");

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
            //_queryBloc.add(CustomerQueryEventAddToList(state.customer));
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (_, state) {
            Customer customer = bloc.customer;
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
