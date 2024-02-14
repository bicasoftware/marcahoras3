import 'package:flutter/material.dart';
import 'package:marcahoras3/presentation_layer/resources/colors.dart';

import '../../../domain_layer/models/empregos.dart';
import '../../../widgets/card_container.dart';

class EmpregoCard extends StatefulWidget {
  final List<Empregos> empregos;
  final Empregos selectedEmprego;

  const EmpregoCard({
    required this.empregos,
    required this.selectedEmprego,
    super.key,
  });

  @override
  State<EmpregoCard> createState() => _EmpregoCardState();
}

class _EmpregoCardState extends State<EmpregoCard>
    with SingleTickerProviderStateMixin {
  late final List<Tab> tabs;
  late final TabController controller;

  int get currentIndex {
    if (widget.empregos.isEmpty) return 0;
    final index = widget.empregos.indexOf(widget.selectedEmprego);
    return index < 0 ? 0 : index;
  }

  @override
  void initState() {
    tabs = widget.empregos
        .map(
          (e) => Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.work_outline),
                const SizedBox(width: 8),
                Text(e.descricao),
              ],
            ),
          ),
        )
        .toList();

    controller = TabController(
      vsync: this,
      length: tabs.length,
      initialIndex: currentIndex,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: TabBar(
        controller: controller,
        tabs: tabs,
        indicatorColor: AppColors.primary.withAlpha(60),
        dividerColor: Colors.transparent,
      ),
    );
  }
}
