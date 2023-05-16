import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/customer_new_bloc.dart';

class CustomerNew extends StatelessWidget {
  CustomerNew({Key? key}) : super(key: key);
  final GlobalKey formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CustomerNewBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo cliente"),
        actions: [
          IconButton(
            onPressed: () {},
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
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Celular'),
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
