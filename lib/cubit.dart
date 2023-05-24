import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit({this.initialData = 0}) : super(initialData);
  int initialData;

  int? current;
  int? next;

  void tambahData() {
    emit(state + 1);
  }

  void kurangData() {
    emit(state - 1);
  }

  // fitur untuk memantau perubahan data
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(error);
  }
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  CounterCubit mycounter = CounterCubit(initialData: 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cubit App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            initialData: mycounter.initialData,
            stream: mycounter.stream,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Center(
                      child: Text(
                    "${snapshot.data}",
                    style: const TextStyle(fontSize: 30),
                  )),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    mycounter.kurangData();
                  },
                  icon: const Icon(Icons.remove)),
              IconButton(
                  onPressed: () {
                    mycounter.tambahData();
                  },
                  icon: const Icon(Icons.add))
            ],
          )
        ],
      ),
    );
  }
}
