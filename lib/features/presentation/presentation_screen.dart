import 'package:flutter/material.dart';

import '../../resources.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen>
    with SingleTickerProviderStateMixin {
  late final PageController controller;

  int pos = 0;

  @override
  void initState() {
    controller = PageController(
      initialPage: 0,
      keepPage: false,
      viewportFraction: 0.8,
    )..addListener(_onPosChanged);

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_onPosChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: 3,
              itemBuilder: (_, i) {
                return Center(
                  child: Text("Page $i"),
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: CircleAvatar(
                      backgroundColor:
                          i == pos ? AppColors.primary : AppColors.disabled,
                      radius: 6,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onPosChanged() {
    final int newPos = controller.page!.toInt();
    print(newPos);
    if (newPos != pos) {
      setState(() => pos == controller.page);
    }
  }
}
