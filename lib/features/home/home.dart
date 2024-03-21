import 'package:flutter/material.dart';
import 'package:marcahoras3/features/home/home_content.dart';
import 'package:marcahoras3/presentation_layer/blocs/home/home_state.dart';
import 'package:marcahoras3/widgets/bloc_watcher.dart';

import '../../presentation_layer/blocs/home/home_bloc.dart';
import '../../strings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.appName),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
      ),
      body: BlocWatcher<HomeBloc, HomeState>(
        builder: (c, HomeState s) {
          return const SingleChildScrollView(child: HomeContent());
        },
      ),
    );
  }
}
