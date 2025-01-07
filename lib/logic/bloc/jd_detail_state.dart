part of 'jd_detail_cubit.dart';

@immutable
class JdDetailState {
  final List<JDData>? listData;
  JD_DetailData? detail;
  final String? error;
   JdDetailState({this.listData, this.error,this.detail});

  JdDetailState copyWith({List<JDData>? listData, String? error,JD_DetailData? detail}) {
    return JdDetailState(
        listData: listData ?? this.listData, error: error ?? this.error,detail: detail ?? this.detail);
  }
}

final class JdDetailInitial extends JdDetailState {}

class LoadingState extends JdDetailState {}

class JdDetailLoadingSuccess extends JdDetailState {
   JdDetailLoadingSuccess({super.listData});
}

class LoadingError extends JdDetailState {
   LoadingError(String error) : super(error: error);
}

class JobDetailLoadingSuccess extends JdDetailState {
  JobDetailLoadingSuccess({super.detail});
}
