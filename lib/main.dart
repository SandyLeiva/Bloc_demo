import 'package:demo_bloc/home/cubit/home_cubit.dart';
import 'package:demo_bloc/login/cubit/login_cubit.dart';
import 'package:demo_bloc/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_repository/package_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PackageRepository(),
       child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()), // Cubit para login
          BlocProvider(create: (context) => HomeCubit(context.read<PackageRepository>())), // Cubit para Home
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false, 
          title: 'Prueba bloc',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          ),
          home: const LoginPage(),
        ),
      ),
    );
  }
}