import 'package:agendamentos/pages/customer/import/bloc/customer_import_bloc.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_event.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_state.dart';
import 'package:agendamentos/pages/customer/import/model/checkbox_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class CustomerImport extends StatelessWidget {
  const CustomerImport({Key? key}) : super(key: key);

  void _onPressedSave(CustomerImportBloc importBloc) {
    importBloc.add(CustomerImportEventSubmitted());
  }

  List<Widget> _actionsBar(CustomerImportBloc importBloc) => [
        IconButton(
          onPressed: () => _onPressedSave(importBloc),
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
      body: BlocListener(
        bloc: importBloc,
        listener: (_, state) {
          if (state is CustomerImportStateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
          } else if (state is CustomerImportStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder(
          bloc: importBloc,
          builder: (_, state) {
            List<CheckboxContact> contacts = [];
            if (state is CustomerImportStateContacts) {
              contacts.addAll(state.contacts);
            }
            return Skeleton(
              isLoading: state is CustomerImportStateLoading,
              skeleton: SkeletonListView(padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10)),
              child: contacts.isEmpty
                  ? const Center(child: Text('Nenhum registro encontrado'))
                  : Card(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        itemBuilder: (_, index) {
                          var c = contacts[index];
                          var phone = '';
                          //@@apenas teste hugo
                          try {
                            phone = c.contact.phones?[0].value ?? '';
                          } catch (e) {
                            phone = 'inde~finido';
                          }
                          //@@ remover o teste

                          return CheckboxListTile(
                            title: Text(
                              c.contact.displayName!,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(phone),
                            value: c.isChecked,
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
      ),
    );
  }
}
