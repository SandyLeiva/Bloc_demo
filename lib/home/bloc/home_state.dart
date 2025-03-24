import 'package:equatable/equatable.dart';
import 'package:package_repository/package_repository.dart';

enum HomeStatus { loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<GifModel> gifs;

  const HomeState({this.status = HomeStatus.loading, this.gifs = const <GifModel>[]});

  HomeState copyWith({HomeStatus? status, List<GifModel>? gifs}) {
    return HomeState(
      status: status ?? this.status,
      gifs: gifs ?? this.gifs,
    );
  }

  @override
  List<Object> get props => [status, gifs];
}
