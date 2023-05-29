import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/arguments/args_customer_new.dart';
import 'bloc/customer_new_bloc.dart';

class CustomerNew extends StatelessWidget {
  final ArgsCustomerNew arguments;

  const CustomerNew({Key? key, required this.arguments}) : super(key: key);

  SizedBox spaceHeight() {
    return const SizedBox(height: 14);
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CustomerNewBloc>(context);

    TextEditingController nameController = TextEditingController();
    TextEditingController cellphoneController = TextEditingController();

    handleValues(Customer customer) {
      nameController.text = customer.name;
      cellphoneController.text = customer.cellphone;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu cliente'),
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
            // when this screen is invoked by query screen, we don't need to call a
            // event, else, if this screen was invoked by info screen, in this case, we need to refresh data.
            arguments.source == TSource.tInfoScreen ? arguments.infoBloc.add(CustomerInfoEventRefresh(customer: state.customer)) : null;
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
            state is CustomerNewStateLoaded ? handleValues(state.customer) : null;

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
