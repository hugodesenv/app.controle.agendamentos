import 'package:agendamentos/pages/customer/import/bloc/customer_import_bloc.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_event.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import '../../../model/checkbox/simpleContact.dart';

class CustomerImport extends StatelessWidget {
  const CustomerImport({Key? key}) : super(key: key);

  List<Widget> _actionsBar(CustomerImportBloc importBloc) => [
        IconButton(
          onPressed: () => importBloc.add(CustomerImportEventSubmitted()),
          icon: const Icon(Icons.save_outlined),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    var importBloc = BlocProvider.of<CustomerImportBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Importar dos contatos'),
        actions: _actionsBar(importBloc),
      ),
      body: BlocBuilder(
        bloc: importBloc,
        builder: (_, state) {
          bool isLoading = state is CustomerImportStateLoading;

          List<CheckboxContact> contacts = [];
          state is CustomerImportStateContacts ? contacts.addAll(state.contacts) : [];

          return Skeleton(
            isLoading: isLoading,
            skeleton: SkeletonListView(padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10)),
            child: contacts.isEmpty
                ? const Center(child: Text('Nenhum registro encontrado'))
                : Card(
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        var contact = contacts[index];
                        return CheckboxListTile(
                          title: Text(contact.contact.displayName!),
                          value: contact.isChecked,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (bool? checked) => importBloc.add(CustomerImportEventChanged(isSelected: checked, index: index)),
                        );
                      },
                      itemCount: contacts.length,
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
