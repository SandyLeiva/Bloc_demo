import 'package:demo_bloc/home/bloc/home_event.dart';
import 'package:demo_bloc/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_repository/package_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PackageRepository gifRepository;

  HomeBloc(this.gifRepository) : super(const HomeState()) {
    on<FetchGifs>(_onFetchGifs);
  }

  Future<void> _onFetchGifs(FetchGifs event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final gifUrls = await gifRepository.getUrls();
      emit(state.copyWith(status: HomeStatus.success, gifs: gifUrls));
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}
