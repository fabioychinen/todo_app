import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/application/core/routes.dart';
import 'package:todo_app/application/pages/home/bloc/cubit/navigation_todo_cubit.dart';

class BasicApp extends StatelessWidget {
  const BasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationToDoCubit>(
      create: (context) => NavigationToDoCubit(),
      child: MaterialApp.router(
        title: 'ToDo App',
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
        ],
        themeMode: ThemeMode.system,
        theme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
          ),
        ),
        routerConfig: routes,
      ),
    );
  }
}
