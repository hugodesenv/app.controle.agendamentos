import 'package:agendamentos/features/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/features/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/features/customer/new/formz/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../enum/formulario_estado_enum.dart';
import '../../../utils/constants/widgetsConstantes.dart';
import 'bloc/customer_new_bloc.dart';

class CustomerNew extends StatelessWidget {
  const CustomerNew({Key? key}) : super(key: key);

  SizedBox spaceHeight() {
    return const SizedBox(height: 14);
  }

  _save(FormularioEstado status, CustomerNewBloc bloc) {
    if (status != FormularioEstado.EM_PROGRESSO) {
      bloc.add(CustomerNewEventSubmitted());
    }
  }

  Widget _getIconSave(FormularioEstado status, BuildContext context) {
    var color = Theme.of(context).primaryColor;
    return status == FormularioEstado.EM_PROGRESSO
        ? Icon(Icons.access_time_rounded, color: color)
        : const Icon(Icons.save_outlined);
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CustomerNewBloc>(context);
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is CustomerNewState) {
          if (state.status == FormularioEstado.SUCESSO) {
            mySnackbar(context, state.message);
            Navigator.pop(context);
          } else if (state.status == FormularioEstado.FALHA) {
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
            ),
            body: SingleChildScrollView(
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
            floatingActionButton: FloatingActionButton(
              onPressed: () => _save(state.status, bloc),
              child: _getIconSave(state.status, context),
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
            errorText: (state.name.displayError != null)
                ? state.name.displayError?.text()
                : null,
          ),
          onChanged: (value) => context
              .read<CustomerNewBloc>()
              .add(CustomerNewEventNameChanged(value)),
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
            errorText: (state.cellphone.displayError != null)
                ? state.cellphone.displayError?.text()
                : null,
          ),
          onChanged: (value) => context
              .read<CustomerNewBloc>()
              .add(CustomerNewEventCellphoneChanged(value)),
        );
      },
    );
  }
}
