import 'package:bloc_pattern/bloc/counter/counter_bloc.dart';
import 'package:bloc_pattern/bloc/counter/counter_events.dart';
import 'package:bloc_pattern/bloc/counter/counter_state.dart';
import 'package:bloc_pattern/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(
                  state.counter.toString(),
                  style: TextStyle(fontSize: Sizes.h1),
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  context.read<CounterBloc>().add(IncrementCounterEvent());
                },
                child: const Text('Increment')),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  context.read<CounterBloc>().add(DecrementCounterEvent());
                },
                child: const Text('Decrement')),
          ],
        ),
      ),
    );
  }
}
