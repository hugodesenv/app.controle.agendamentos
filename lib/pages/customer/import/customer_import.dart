import 'package:agendamentos/pages/customer/import/bloc/customer_import_bloc.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_state.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class CustomerImport extends StatelessWidget {
  const CustomerImport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CustomerImportBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Importar dos contatos')),
      body: BlocBuilder(
        bloc: bloc,
        builder: (_, state) {
          bool isLoading = state is CustomerImportStateLoading;
          List<Contact> contacts =
              state is CustomerImportStateContacts ? state.contacts : [];
          return Skeleton(
            isLoading: isLoading,
            skeleton: SkeletonListView(
                padding: const EdgeInsets.only(
                    left: 10, top: 5, right: 10, bottom: 10)),
            child: contacts.isEmpty
                ? const Center(child: Text('Nenhum registro encontrado'))
                : Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, top: 20, left: 5, right: 5),
                          child: Text(
                            'Contatos do dispositivo',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (_, index) {
                              Contact contact = contacts[index];
                              return ListTile(
                                title: Text(contact.displayName!),
                                onTap: () => print(contact.displayName!),
                              );
                            },
                            itemCount: contacts.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
