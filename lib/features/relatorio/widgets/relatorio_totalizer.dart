import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils.dart';
import 'relatorio_totalizer_row.dart';

class TotalsContainer extends StatefulWidget {
  final ReportModel report;

  const TotalsContainer({required this.report, super.key});

  @override
  State<TotalsContainer> createState() => _TotalsContainerState();
}

class _TotalsContainerState extends State<TotalsContainer> {
  late final ExpansibleController _controller;
  

  @override
  void initState() {
    _controller = ExpansibleController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    _controller.isExpanded ? _controller.collapse() : _controller.expand();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final _weekDaysLabel = Localiza.findList('fullWeekDays');

    return Hero(
      tag: "totais_button",
      flightShuttleBuilder:
          (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            return SingleChildScrollView(child: toHeroContext.widget);
          },
      child: Expansible(
        controller: _controller,
        duration: Duration(milliseconds: 300),
        maintainState: true,
        headerBuilder: (_, _) {
          return GestureDetector(
            onTap: _toggleExpansion,
            child: Container(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                // bottom: 16,
              ),
              decoration: BoxDecoration(
                color: AppColors.inversePrimary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 4,
                    spreadRadius: .2,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        Localiza.find('totais'),
                        style: theme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.onPrimary,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        _controller.isExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: AppColors.onPrimary,
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.onInverseSurface),
                  if (!_controller.isExpanded)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          RelatorioTotalizerRow(
                            label: Localiza.find('totais'),
                            color: AppColors.onPrimary,
                            horasTrab: widget.report.total.getWorkedHours(),
                            valor: widget.report.total.getAmount(),
                            hideTotal: widget.report.bancoHoras,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        bodyBuilder: (_, _) {
          return Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
            decoration: BoxDecoration(
              color: AppColors.inversePrimary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 4,
                  spreadRadius: .2,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.report.bancoHoras) ...[
                  RelatorioTotalizerRow(
                    label: Localiza.find('bancoHorasAbrev'),
                    color: AppColors.bancoHorasColor,
                    horasTrab: widget.report.horasBanco!.getWorkedHours(),
                    valor: '',
                    hideTotal: true,
                  ),
                  RelatorioTotalizerRow(
                    label: Localiza.find('compensada'),
                    color: AppColors.bancoBurnedColor,
                    horasTrab: widget.report.horasCompensadas!.getWorkedHours(),
                    valor: '',
                    hideTotal: true,
                  ),
                ] else ...[
                  RelatorioTotalizerRow(
                    label: Localiza.find('normais'),
                    color: AppColors.porcNormalColor,
                    horasTrab: widget.report.normais.getWorkedHours(),
                    valor: widget.report.normais.getAmount(),
                    hideTotal: false,
                  ),
                  RelatorioTotalizerRow(
                    label: Localiza.find('feriado'),
                    color: AppColors.porcFeriadosColor,
                    horasTrab: widget.report.feriados.getWorkedHours(),
                    valor: widget.report.feriados.getAmount(),
                    hideTotal: false,
                  ),
                  if (widget.report.diferenciadas.isNotEmpty) ...[
                    for (final dif in widget.report.diferenciadas)
                      RelatorioTotalizerRow(
                        label: _weekDaysLabel[dif.weekday],
                        color: dif.color,
                        horasTrab: dif.getWorkedHours(),
                        valor: dif.getAmount(),
                        hideTotal: false,
                      ),
                  ],
                ],
                RelatorioTotalizerRow(
                  label: Localiza.find('totais'),
                  color: AppColors.onPrimary,
                  horasTrab: widget.report.total.getWorkedHours(),
                  valor: widget.report.total.getAmount(),
                  hideTotal: widget.report.bancoHoras,
                ),
              ],
            ),
          );
        },
        // child: Container(
        //   padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
        //   decoration: BoxDecoration(
        //     color: AppColors.inversePrimary,
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(16),
        //       topRight: Radius.circular(16),
        //     ),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black54,
        //         blurRadius: 4,
        //         spreadRadius: .2,
        //         offset: Offset(0, 0),
        //       ),
        //     ],
        //   ),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: [
        //       Text(
        //         Localiza.find('totais'),
        //         style: theme.bodyLarge?.copyWith(
        //           fontWeight: FontWeight.bold,
        //           color: AppColors.onPrimary,
        //           fontSize: 20,
        //         ),
        //       ),
        //       const Divider(color: AppColors.onInverseSurface),
        //     ],
        //   ),
        // ),
      ),
    );
    // return Hero(
    //   tag: "totais_button",
    //   flightShuttleBuilder:
    //       (
    //         flightContext,
    //         animation,
    //         flightDirection,
    //         fromHeroContext,
    //         toHeroContext,
    //       ) {
    //         return SingleChildScrollView(child: toHeroContext.widget);
    //       },
    //   child: Container(
    //     padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
    //     decoration: BoxDecoration(
    //       color: AppColors.inversePrimary,
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(16),
    //         topRight: Radius.circular(16),
    //       ),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black54,
    //           blurRadius: 4,
    //           spreadRadius: .2,
    //           offset: Offset(0, 0),
    //         ),
    //       ],
    //     ),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Text(
    //           Localiza.find('totais'),
    //           style: theme.bodyLarge?.copyWith(
    //             fontWeight: FontWeight.bold,
    //             color: AppColors.onPrimary,
    //             fontSize: 20,
    //           ),
    //         ),
    //         const Divider(color: AppColors.onInverseSurface),
    //         if (report.bancoHoras) ...[
    //           RelatorioTotalizerRow(
    //             label: Localiza.find('bancoHorasAbrev'),
    //             color: AppColors.bancoHorasColor,
    //             horasTrab: report.horasBanco!.getWorkedHours(),
    //             valor: '',
    //             hideTotal: true,
    //           ),
    //           RelatorioTotalizerRow(
    //             label: Localiza.find('compensada'),
    //             color: AppColors.bancoBurnedColor,
    //             horasTrab: report.horasCompensadas!.getWorkedHours(),
    //             valor: '',
    //             hideTotal: true,
    //           ),
    //         ] else ...[
    //           RelatorioTotalizerRow(
    //             label: Localiza.find('normais'),
    //             color: AppColors.porcNormalColor,
    //             horasTrab: report.normais.getWorkedHours(),
    //             valor: report.normais.getAmount(),
    //             hideTotal: false,
    //           ),
    //           RelatorioTotalizerRow(
    //             label: Localiza.find('feriado'),
    //             color: AppColors.porcFeriadosColor,
    //             horasTrab: report.feriados.getWorkedHours(),
    //             valor: report.feriados.getAmount(),
    //             hideTotal: false,
    //           ),
    //           if (report.diferenciadas.isNotEmpty) ...[
    //             for (final dif in report.diferenciadas)
    //               RelatorioTotalizerRow(
    //                 label: Localiza.find('diferencial'),
    //                 color: dif.color,
    //                 horasTrab: dif.getWorkedHours(),
    //                 valor: dif.getAmount(),
    //                 hideTotal: false,
    //               ),
    //           ],
    //         ],
    //         RelatorioTotalizerRow(
    //           label: Localiza.find('totais'),
    //           color: AppColors.onPrimary,
    //           horasTrab: report.total.getWorkedHours(),
    //           valor: report.total.getAmount(),
    //           hideTotal: report.bancoHoras,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
