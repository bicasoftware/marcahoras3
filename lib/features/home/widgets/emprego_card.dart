import 'package:flutter/material.dart';
import 'package:marcahoras3/resources/colors.dart';

import '../../../domain_layer/models.dart';
import '../../../widgets.dart';


class EmpregoCard extends StatefulWidget {
  final List<Empregos> empregos;
  final int? empregoPos;

  const EmpregoCard({
    required this.empregos,
    this.empregoPos,
    super.key,
  });

  @override
  State<EmpregoCard> createState() => _EmpregoCardState();
}

class _EmpregoCardState extends State<EmpregoCard>
    with SingleTickerProviderStateMixin {
  late final List<Tab> tabs;
  late final TabController controller;

  int? get currentIndex {
    return widget.empregos.isEmpty ? 0 : widget.empregoPos;
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
      initialIndex: currentIndex ?? 0,
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
