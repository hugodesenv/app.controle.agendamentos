import 'package:agendamentos/pages/customer/register/import/bloc/customer_import_bloc.dart';
import 'package:agendamentos/pages/customer/register/import/bloc/customer_import_state.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerRegisterImport extends StatelessWidget {
  const CustomerRegisterImport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Importar dos contatos")),
      body: BlocBuilder(
        bloc: BlocProvider.of<CustomerImportBloc>(context),
        builder: (_, state) {
          if (state is CustomerImportStateContacts) {
            return ListView.builder(
              itemBuilder: (_, index) {
                Contact contact = state.contacts[index];
                return ListTile(
                  title: Text(contact.displayName!),
                );
              },
            );
          }
          return Container(child: Text('testing...'));
        },
      ),
    );
  }
}
