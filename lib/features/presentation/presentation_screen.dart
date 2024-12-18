import 'package:collection/collection.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:marcahoras3/features/presentation/widgets/presentation_emprego%20admissao.dart';
import 'package:marcahoras3/features/presentation/widgets/presentation_emprego_carga_horaria.dart';
import 'package:marcahoras3/features/presentation/widgets/presentation_emprego_descricao.dart';
import 'package:marcahoras3/features/presentation/widgets/presentation_emprego_salario.dart';

import '../../domain_layer/models.dart';
import '../../resources.dart';
import 'presentation_carousel_navigator.dart';
import 'presentation_page.dart';
import 'presentation_page_model.dart';
import 'widgets/presentation_emprego_porc.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  final txtDescricao = TextEditingController(text: '');
  final txtSalario = MoneyMaskedTextController(
    leftSymbol: "R\$",
    initialValue: 0.0,
  );
  var emprego = Empregos(
    porcNormal: 50, porcFeriado: 100,
  );

  int pos = 0;

  @override
  void initState() {
    controller = TabController(
      length: 8,
      vsync: this,
      initialIndex: 0,
    )..addListener(_onPosChanged);

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_onPosChanged);
    txtDescricao.dispose();
    txtSalario.dispose();
    super.dispose();
  }

  List<PresentationPageModel> _buildPages(BuildContext context) {
    final strings = context.strings();
    return [
      PresentationPageModel(
        title: strings.welcomeTitle,
        message: strings.welcomeMessage,
        image: AppImages.introWelcome,
        child: Container(),
      ),
      PresentationPageModel(
        title: strings.welcomeJobDescription,
        message: strings.welcomeJobDescriptionMessage,
        image: AppImages.introJobDescription,
        child: Container(
          child: PresentationEmpregoDescricao(
            controller: txtDescricao,
            onTextChanged: (v) =>
                setState(() => emprego = emprego.copyWith(descricao: v)),
          ),
        ),
      ),
      PresentationPageModel(
        title: strings.welcomeAdmissao,
        message: strings.welcomeAdmissaoMessage,
        image: AppImages.introValues,
        child: Container(
          child: PresentationEmpregoAdmissao(
            date: emprego.admissao ?? DateTime.now(),
            onDateChanged: (d) {
              setState(() => emprego = emprego.copyWith(admissao: d));
            },
          ),
        ),
      ),
      PresentationPageModel(
        title: strings.welcomePorcNormal,
        message: strings.welcomePorcNormalMessage,
        image: AppImages.introPorcentagem,
        child: Container(
          child: PresentationEmpregoPorc(
            tipoHora: HorasType.normal,
            porc: emprego.porcNormal,
            onPorcChanged: (p) {
              setState(() => emprego = emprego.copyWith(porcNormal: p));
            },
          ),
        ),
      ),
      PresentationPageModel(
        title: strings.welcomePorcFeriado,
        message: strings.welcomePorcFeriadoMessage,
        image: AppImages.introPorcentagens,
        child: Container(
          child: PresentationEmpregoPorc(
            tipoHora: HorasType.feriado,
            porc: emprego.porcFeriado,
            onPorcChanged: (p) {
              setState(() => emprego = emprego.copyWith(porcFeriado: p));
            },
          ),
        ),
      ),
      PresentationPageModel(
        title: strings.welcomeCargaHoraria,
        message: strings.welcomeCargaHorariaMessage,
        image: AppImages.introValues,
        child: PresentationEmpregoCargaHoraria(
          cargaHoraria: emprego.cargaHoraria,
          onCargaSelected: (c) => setState(
            () => emprego = emprego.copyWith(cargaHoraria: c),
          ),
        ),
      ),
      PresentationPageModel(
        title: strings.welcomeSalario,
        message: strings.welcomeSalarioMessage,
        image: AppImages.introValues,
        child: PresentationEmpregoSalario(
          controller: txtSalario,
          onSalarioChanged: (s) {
            setState(
              () => emprego = emprego.copyWith(salario: txtSalario.numberValue),
            );
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              children: pages.mapIndexed((i, p) {
                return PresentationPage(
                  message: p.message,
                  title: p.title,
                  image: p.image,
                  child: Container(
                    child: p.child,
                  ),
                );
              }).toList(),
            ),
          ),
          CarouselNavigator(
            length: pages.length,
            currentPos: pos,
            onBackTapped: () => controller.animateTo(pos - 1),
            onNextTapped: () => controller.animateTo(pos + 1),
            onFinishedTapped: () => print('finalizado'),
          ),
        ],
      ),
    );
  }

  void _onPosChanged() {
    final int newPos = controller.index;
    if (newPos != pos) {
      setState(() => pos = newPos);
    }
  }
}
