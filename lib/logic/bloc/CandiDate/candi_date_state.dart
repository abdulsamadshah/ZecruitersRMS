part of 'candi_date_cubit.dart';



@immutable
class CandiDateState {
  final List<CandiDateData>? listData;
  // Job_DetailData? detail;
  final String? error;
  CandiDateState({this.listData, this.error,});

  CandiDateState copyWith({List<CandiDateData>? listData, String? error,}) {
    return CandiDateState(
        listData: listData ?? this.listData, error: error ?? this.error,);
  }
}

final class CandiDateInitial extends CandiDateState {}

class LoadingState extends CandiDateState {}

class CandiDateLoadingSuccess extends CandiDateState {
  CandiDateLoadingSuccess({super.listData});
}

class LoadingError extends CandiDateState {
  LoadingError(String error) : super(error: error);
}

// class JobDetailLoadingSuccess extends JdDetailState {
//   JobDetailLoadingSuccess({super.detail});
// }

