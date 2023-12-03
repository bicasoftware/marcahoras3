import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation_layer/blocs/home/home_bloc.dart';
import '../../strings.dart';
import '../../widgets/state_listener.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<HomeBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.appName),
      ),
      body: StateListener(
        state: c.state,
        onSuccessView: (s) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, i) => const Divider(),
                  itemCount: c.state.empregos.length,
                  itemBuilder: (_, i) => ListTile(
                    leading: const CircleAvatar(
                      foregroundColor: Colors.red,
                      child: Icon(Icons.cases_outlined, color: Colors.black),
                    ),
                    title: Text(
                      c.state.empregos[i].descricao,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {},
                  child: const Text(
                    Strings.tentar,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
