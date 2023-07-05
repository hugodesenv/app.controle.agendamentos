import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/pages/customer/new/formz/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/form_submission_status.dart';
import '../../../assets/utilsConstantes.dart';
import 'bloc/customer_new_bloc.dart';

class CustomerNew extends StatelessWidget {
  const CustomerNew({Key? key}) : super(key: key);

  SizedBox spaceHeight() {
    return const SizedBox(height: 14);
  }

  _save(FormSubmissionStatus status, CustomerNewBloc bloc) {
    if (status != FormSubmissionStatus.inProgress) {
      bloc.add(CustomerNewEventSubmitted());
    }
  }

  Widget _getIconSave(FormSubmissionStatus status, BuildContext context) {
    var color = Theme.of(context).primaryColor;
    return status == FormSubmissionStatus.inProgress ? Icon(Icons.access_time_rounded, color: color) : const Icon(Icons.save_outlined);
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CustomerNewBloc>(context);
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is CustomerNewState) {
          if (state.status == FormSubmissionStatus.success) {
            mySnackbar(context, state.message);
            Navigator.pop(context);
          } else if (state.status == FormSubmissionStatus.failure) {
            mySnackbar(context, state.message, background: Colors.red);
          }
        }
      },
      child: BlocBuilder(
        bloc: bloc,
        builder: (_, CustomerNewState state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Meu cliente'),
              actions: [
                IconButton(
                  onPressed: () => _save(state.status, bloc),
                  icon: _getIconSave(state.status, context),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).highlightColor,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _NameInput(),
                    spaceHeight(),
                    const _CellphoneInput(),
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

class _NameInput extends StatelessWidget {
  const _NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerNewBloc, CustomerNewState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (BuildContext context, state) {
        return TextFormField(
          initialValue: state.name.value,
          decoration: InputDecoration(
            labelText: 'Nome *',
            errorText: (state.name.displayError != null) ? state.name.displayError?.text() : null,
          ),
          onChanged: (value) => context.read<CustomerNewBloc>().add(CustomerNewEventNameChanged(value)),
        );
      },
    );
  }
}

class _CellphoneInput extends StatelessWidget {
  const _CellphoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerNewBloc, CustomerNewState>(
      buildWhen: (previous, current) => previous.cellphone != current.cellphone,
      builder: (BuildContext context, state) {
        return TextFormField(
          initialValue: state.cellphone.value,
          decoration: InputDecoration(
            labelText: 'Celular',
            errorText: (state.cellphone.displayError != null) ? state.cellphone.displayError?.text() : null,
          ),
          onChanged: (value) => context.read<CustomerNewBloc>().add(CustomerNewEventCellphoneChanged(value)),
        );
      },
    );
  }
}
