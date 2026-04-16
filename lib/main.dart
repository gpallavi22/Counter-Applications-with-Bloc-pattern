import 'package:bloc_pattern/bloc/counter/counter_bloc.dart';
import 'package:bloc_pattern/bloc/image_picker/image_picker_bloc.dart';
import 'package:bloc_pattern/bloc/switch/switch_bloc.dart';
import 'package:bloc_pattern/utils/Image_picker_utils.dart';
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
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
            BlocProvider<SwitchBloc>(create: (context) => SwitchBloc()),
            BlocProvider<ImagePickerBloc>(create: (context) => ImagePickerBloc(ImagePickerUtils())),
          ],
          child: MaterialApp(
            title: 'Bloc Structure Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: RoutesName.imagePickerScreen,
            onGenerateRoute: Routes.generateRoute,
          ),
        );
      },
    );
  }
}
