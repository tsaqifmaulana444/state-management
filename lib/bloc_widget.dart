import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/counter.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  Counter mycounter = Counter();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Bloc Builder")),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          BlocBuilder<Counter, int>(
            bloc: mycounter,
            buildWhen: (previous, current) {
              if (current % 2 == 0){
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              return Text("$state", style: const TextStyle(fontSize: 40));
            },
          ),
          // StreamBuilder(
          //   initialData: mycounter.init,
          //   stream: mycounter.stream,
          //   builder: (context, snapshot) {
          //     return Text("${snapshot.data}",
          //         style: const TextStyle(fontSize: 40));
          //   },
          // ),
          const SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    mycounter.decrement();
                  },
                  icon: const Icon(Icons.remove)),
              IconButton(
                  onPressed: () {
                    mycounter.increment();
                  },
                  icon: const Icon(Icons.add))
            ],
          )
        ]));
  }
}
