import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

import '../../domain_layer/models.dart';
import '../../resources.dart';
import 'presentation_carousel_navigator.dart';
import 'presentation_logo_container.dart';
import 'presentation_page.dart';
import 'widgets/widgets.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen>
    with SingleTickerProviderStateMixin {
  late final PageController controller;
  final txtDescricao = TextEditingController(text: '');
  final txtSalario = MoneyMaskedTextController(
    leftSymbol: "R\$",
    initialValue: 0.0,
  );
  var emprego = Empregos(
    porcNormal: 50,
    porcFeriado: 100,
  );

  int pos = 0;

  @override
  void initState() {
    controller = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: .9,
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

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PresentationLogoContainer(),
          ),
          SizedBox(
            height: 250,
            child: PageView(
              controller: controller,
              pageSnapping: true,
              onPageChanged: (p) => setState(() => pos = p),
              children: [
                /// Job description textfield
                PresentationPage(
                  title: strings.welcomeJobDescription,
                  message: strings.welcomeJobDescriptionMessage,
                  child: Container(
                    child: PresentationEmpregoDescricao(
                      controller: txtDescricao,
                      onTextChanged: (v) => setState(
                          () => emprego = emprego.copyWith(descricao: v)),
                    ),
                  ),
                ),

                /// Work start Date
                PresentationPage(
                  title: strings.welcomeAdmissao,
                  message: strings.welcomeAdmissaoMessage,
                  child: Container(
                    child: PresentationEmpregoAdmissao(
                      date: emprego.admissao ?? DateTime.now(),
                      onDateChanged: (d) {
                        setState(() => emprego = emprego.copyWith(admissao: d));
                      },
                    ),
                  ),
                ),

                /// Overtime extra percentage
                PresentationPage(
                  title: strings.welcomePorcNormal,
                  message: strings.welcomePorcNormalMessage,
                  child: Container(
                    child: PresentationEmpregoPorc(
                      tipoHora: HorasType.normal,
                      porc: emprego.porcNormal,
                      onPorcChanged: (p) {
                        setState(
                            () => emprego = emprego.copyWith(porcNormal: p));
                      },
                    ),
                  ),
                ),

                /// Overtime extra percentage on holidays
                PresentationPage(
                  title: strings.welcomePorcFeriado,
                  message: strings.welcomePorcFeriadoMessage,
                  child: Container(
                    child: PresentationEmpregoPorc(
                      tipoHora: HorasType.feriado,
                      porc: emprego.porcFeriado,
                      onPorcChanged: (p) {
                        setState(
                            () => emprego = emprego.copyWith(porcFeriado: p));
                      },
                    ),
                  ),
                ),

                /// Regular working hours in the month
                PresentationPage(
                  title: strings.welcomeCargaHoraria,
                  message: strings.welcomeCargaHorariaMessage,
                  child: PresentationEmpregoCargaHoraria(
                    cargaHoraria: emprego.cargaHoraria,
                    onCargaSelected: (c) => setState(
                      () => emprego = emprego.copyWith(cargaHoraria: c),
                    ),
                  ),
                ),

                /// Monthly Salary
                PresentationPage(
                  title: strings.welcomeSalario,
                  message: strings.welcomeSalarioMessage,
                  child: PresentationEmpregoSalario(
                    controller: txtSalario,
                    onSalarioChanged: (s) {
                      setState(
                        () => emprego =
                            emprego.copyWith(salario: txtSalario.numberValue),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          CarouselNavigator(
            length: 6,
            currentPos: pos,
            onBackTapped: () => controller.jumpTo(pos - 1),
            onNextTapped: () => controller.jumpTo(pos + 1),
            onFinishedTapped: () => print('finalizado'),
          ),
        ],
      ),
    );
  }

  void _onPosChanged() {
    final int newPos = controller.page?.floor() ?? 0;
    if (newPos != pos) {
      setState(() => pos = newPos);
    }
  }
}
