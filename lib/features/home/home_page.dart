import 'package:agendamentos/enum/agendamento_situacao_enum.dart';
import 'package:agendamentos/features/agenda/agenda_page.dart';
import 'package:agendamentos/utils/dialogs_util.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/schedule.dart' as scheduleModel;
import '../../models/schedule.dart';
import '../../utils/constants/constants.dart';
import '../../utils/constants/widgetsConstantes.dart';
import '../agenda/components/calendario/agenda_calendario.dart';
import 'home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _usuarioController = TextEditingController();
  final _nomeEmpresaController = TextEditingController();
  late HomeProvider homeProvider;

  @override
  void initState() {
    homeProvider = context.read<HomeProvider>();
    super.initState();

    Future.delayed(Duration.zero).then((value) {
      homeProvider.buscaUsuarioLogado();
      homeProvider.buscarTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: body(),
      drawer: menuLateral(),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _widgetTotalizadores(),
          _widgetCalendario(),
        ],
      ),
    );
  }

  Widget _widgetTotalizadores() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SizedBox(
        height: 80,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            cardsTotalPorSituacao(
              'Em andamento',
              AgendamentoSituacao.emProgresso,
            ),
            cardsTotalPorSituacao(
              'Pendentes',
              AgendamentoSituacao.pendente,
            ),
            cardsTotalPorSituacao(
              'Confirmados',
              AgendamentoSituacao.confirmado,
            ),
            cardsTotalPorSituacao(
              'Cancelados',
              AgendamentoSituacao.cancelado,
            ),
            cardsTotalPorSituacao(
              'Finalizados',
              AgendamentoSituacao.finalizado,
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetCalendario() {
    return Consumer<HomeProvider>(
      builder: (context, controller, _) {
        return Expanded(
          child: AgendaCalendario(
            onCliqueAgendamento: (model) async {
              await abrirDetalhes(context, model);
            },
            onCliqueAgendamentoLivre: (dataHora) async {
              var arguments = Parametros(scheduleDate: dataHora);
              await abrirAdicionarAgendamento(context, params: arguments);
            },
            agendamentos: controller.agendamentos,
            onDataSelecionada: (data) {
              controller.calcularTotalizadores(data);
            },
          ),
        );
      },
    );
  }

  Widget menuLateral() {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<HomeProvider>(
              builder: (context, provider, _) {
                final usuarioConectado = provider.usuarioContectado;
                _usuarioController.text = 'Olá, ${usuarioConectado.nome}';
                _nomeEmpresaController.text =
                    usuarioConectado.empresa.razaoSocial;
                return Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 20, left: 20),
                  child: ListTile(
                    title: Text(
                      _usuarioController.text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      _nomeEmpresaController.text,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        Icons.exit_to_app_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async => await sair(),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      onTap: () => Navigator.pushNamed(
                          context, RoutesConstants.routeCustomerQuery),
                      title: const Text('Clientes'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.hardware_outlined),
                      onTap: () => Navigator.pushNamed(
                          context, RoutesConstants.routeItemPage),
                      title: const Text('Produtos e serviços'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_graph_sharp),
                      onTap: () async => await Navigator.pushNamed(
                          context, RoutesConstants.routeReport),
                      title: const Text('Relatórios'),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            _drawerFixed(
              onTap: () async => Navigator.pushNamed(
                context,
                RoutesConstants.routeProfile,
              ),
              textTitle: 'Configurações',
              iconData: Icons.settings,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Home"),
      actions: [
        PopupMenuButton(
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Atualizar'),
                ),
                onTap: () => homeProvider.buscarTodos(),
              ),
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.pending_actions),
                  title: Text('Incluir'),
                ),
                onTap: () async {
                  //When a pop up menu is clicked, it will call pop() on the navigator to dismiss itself.
                  //So pushing an extra route would cause it to pop that route immediately, instead of dismissing itself.
                  await Future.delayed(Duration.zero).then((_) async {
                    await abrirAdicionarAgendamento(context);
                  });
                },
              ),
            ];
          },
        ),
      ],
    );
  }

  Future<void> abrirAdicionarAgendamento(
    BuildContext context, {
    Parametros? params,
  }) async {
    await Navigator.pushNamed(
      context,
      RoutesConstants.routeSchedule,
      arguments: params,
    );
  }

  abrirDetalhes(BuildContext context, Schedule pAgendamento) async {
    await showModalBottomSheet(
      context: context,
      shape: shapeModalBottomSheet,
      builder: (context) {
        final typeSituation = pAgendamento.situation.text();
        final res = scheduleModel.Schedule.fromText(typeSituation);
        final displaySituation = res[ScheduleFromText.tDescription];
        final colorSituation = res[ScheduleFromText.tColor];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      title: Text(
                        displaySituation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: colorSituation,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                PopupMenuButton(
                  padding: const EdgeInsets.only(top: 10.0),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(child: Text("Alterar")),
                      PopupMenuItem(
                        onTap: () => homeProvider.excluir(pAgendamento),
                        child: const Text(
                          "Excluir",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 0,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_2_outlined),
                      title: const Text("Nome"),
                      subtitle: Text(pAgendamento.customer.name),
                    ),
                    ListTile(
                      leading: const Icon(Icons.local_phone_outlined),
                      title: const Text("Celular"),
                      subtitle: Text(pAgendamento.customer.cellphone),
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer_sharp),
                      title: const Text("Tempo total (Minutos)"),
                      subtitle: Text(pAgendamento.totalMinutes.toString()),
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money_rounded),
                      title: const Text("Preço R\$"),
                      subtitle: Text(pAgendamento.totalPrice.toString()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _drawerFixed({
    required Function onTap,
    required String textTitle,
    required IconData iconData,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(iconData, color: Theme.of(context).primaryColor),
      onTap: () async => await onTap(),
      title: Text(
        textTitle,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Future sair() async {
    await DialogsUtil.confirmation(
      context,
      'Deseja sair?',
      'Espero te ver novamente! :)',
      () async {
        bool res = await homeProvider.deslogar();
        if (!res) return;
        await Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
    );
  }

  Widget cardsTotalPorSituacao(String pTitulo, AgendamentoSituacao pSituacao) {
    return SizedBox(
      width: 150.0,
      child: Center(
        child: ListTile(
          title: Text(
            pTitulo,
            style: const TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Consumer<HomeProvider>(
              builder: (context, controller, child) {
                final sDescricao = UtilBrasilFields.obterReal(
                    controller.totalizadores[pSituacao] ?? 0.0);
                return Text(
                  sDescricao,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
