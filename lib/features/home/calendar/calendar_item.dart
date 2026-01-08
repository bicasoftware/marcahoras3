import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';

class CalendarItem extends StatelessWidget {
  final int weekDay, monthDay;
  final HorasType type;
  final Diferenciais? diferencial;
  final bool isToday;
  final DateTime? data;
  final Horas? hora;
  final bool enabled;
  final void Function(Horas? hora, DateTime? data)? onCalendarItemTap;
  final bool bancoHoras;

  const CalendarItem({
    this.onCalendarItemTap,
    this.weekDay = -1,
    this.monthDay = -1,
    this.type = HorasType.unknown,
    this.isToday = false,
    this.enabled = true,
    this.bancoHoras = false,
    this.hora,
    this.data,
    this.diferencial,
    super.key,
  });

  bool get _enabled => monthDay == -1 && weekDay == -1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return AbsorbPointer(
      absorbing: !enabled,
      child: Ink(
        decoration: monthDay > -1
            ? BoxDecoration(
                color: enabled
                    ? isToday
                          ? colors.secondary.withAlpha(50)
                          : colors.surface
                    : colors.surfaceContainer,
                border: Border.all(color: colors.shadow.withAlpha(20)),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: InkWell(
          splashColor: ExtraColors.splash,
          onTap: () {
            if (onCalendarItemTap != null) {
              onCalendarItemTap!(hora, data);
            }
          },
          child: _enabled
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$monthDay',
                      style: textTheme.bodyLarge?.copyWith(
                        color: enabled ? colors.onSurface : colors.outline,
                      ),
                    ),
                    Container(
                      height: 4,
                      width: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: type != HorasType.unknown
                          ? BoxDecoration(
                              color: _getIndicatorColor(colors),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Color _getIndicatorColor(ColorScheme colors) {
    switch (hora!.tipoHora) {
      case HorasType.feriado:
        return ExtraColors.porcFeriadosColor;
      case HorasType.normal:
        return ExtraColors.porcNormalColor;
      case HorasType.banco:
        return Color(hora?.horaStatus.color ?? colors.outline.toARGB32());
      case HorasType.diferencial:
        return diferencial?.color ?? ExtraColors.porcDiferenciadaColor;
      default:
        return colors.outline;
    }
  }
}
