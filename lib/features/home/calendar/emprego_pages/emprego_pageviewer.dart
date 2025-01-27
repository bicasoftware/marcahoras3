import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/calendar_page_view.dart';
import 'emprego_page.dart';
import '../../../../domain_layer/models.dart';

class EmpregoPageViewer extends StatefulWidget {
  final List<Empregos> empregos;

  const EmpregoPageViewer({
    required this.empregos,
  });

  @override
  State<EmpregoPageViewer> createState() => _EmpregoPageViewerState();
}

class _EmpregoPageViewerState extends State<EmpregoPageViewer> {
  late final PageController controller;
  late final carController;

  @override
  void initState() {
    controller = PageController(
      viewportFraction: 0.8,
      initialPage: 0,
      keepPage: true,
    );

    carController = CarouselController(
      initialItem: 0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // return CarouselView(
    //   itemExtent: w * 0.8,
    //   controller: carController,
    //   enableSplash: true,
    //   itemSnapping: true,
    //   children: widget.empregos
    //       .map(
    //         (e) => EmpregoPage(emprego: e),
    //       )
    //       .toList(),
    // );

    // return CarouselPageView(
    //   children: widget.empregos
    //       .map(
    //         (e) => EmpregoPage(emprego: e),
    //       )
    //       .toList(),
    //   onFinished: () {},
    //   onSkip: () {},
    // );

    return PageView.builder(
      controller: controller,
      itemCount: widget.empregos.length,
      itemBuilder: (_, i) => EmpregoPage(emprego: widget.empregos[i]),
      pageSnapping: true,
      padEnds: false,
      
    );
  }
}
