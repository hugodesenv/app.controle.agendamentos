import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/customer_new_bloc.dart';

class CustomerNew extends StatelessWidget {
  CustomerNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CustomerNewBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo cliente"),
        actions: [
          IconButton(
            onPressed: () => bloc.add(CustomerNewEventSubmitted()),
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (_, state) {
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
    );
  }
}
