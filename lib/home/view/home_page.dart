
import 'package:demo_bloc/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_repository/package_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context.read<PackageRepository>())..getData(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prueba Bloc"),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case HomeStatus.success:
              return GridView.count(
                crossAxisCount: 2,
                children: state.gifs
                    .map((gif) =>  _buildImage(gif)).toList(),
              );
            case HomeStatus.error:
              return const Center(child: Text("Error al cargar"));
          }
        },
      ),
    );
  }

  Widget _buildImage(GifModel gif) {
    return Image.network(
      gif.url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Image.asset('assets/placeholder.gif', fit: BoxFit.cover);
      },
    );
  }
}
