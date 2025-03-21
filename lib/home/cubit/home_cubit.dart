import 'package:bloc/bloc.dart';
import 'package:package_repository/package_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.gifRepository) : super(HomeState());

  final PackageRepository gifRepository;

  Future<void> getData() async {
    try {
      final gifUrls = await gifRepository.getUrls();

      emit(state.copyWith(status: HomeStatus.success, gifs: gifUrls));
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}