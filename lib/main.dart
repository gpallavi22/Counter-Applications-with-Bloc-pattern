import 'package:bloc_pattern/bloc/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<CounterBloc>(
              create: (context) => CounterBloc(),
            ),
          ],
          child: MaterialApp(
            title: 'Bloc Structure Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: RoutesName.counterScreen,
            onGenerateRoute: Routes.generateRoute,
          ),
        );
      },
    );
  }
}
