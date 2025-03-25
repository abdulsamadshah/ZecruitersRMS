part of 'candi_date_cubit.dart';

@immutable
class CandiDateState {
  final List<CandiDateData>? listData;
  final List<CallDetail>? callData;
  var call_start_time;
  var call_end_time;
  var call_duration;

  CandiDateDetail? detail;
  final String? error;
  final List<RemakListData>? remarkData;
  dynamic SelectedremarkData;
  CandiDateState({this.listData, this.error, this.detail,this.callData,this.remarkData,this.SelectedremarkData,this.call_duration,this.call_end_time,this.call_start_time});

  CandiDateState copyWith(
      {List<CandiDateData>? listData, String? error, CandiDateDetail? detail,List<CallDetail>? callData,List<RemakListData>? remarkData,dynamic SelectedremarkData,var call_start_time,call_end_time,call_duration}) {
    return CandiDateState(
        listData: listData ?? this.listData,
        error: error ?? this.error,
        detail: detail ?? this.detail,
    callData: callData ?? this.callData,
      remarkData: remarkData ?? this.remarkData,
      SelectedremarkData: SelectedremarkData ?? this.SelectedremarkData,
      call_duration: call_duration ?? this.call_duration,
      call_end_time: call_end_time ?? this.call_end_time,
      call_start_time: call_start_time ?? this.call_start_time
    );
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

class CandiDateDetailLoadingSuccess extends CandiDateState {
  CandiDateDetailLoadingSuccess({super.detail});
}

class CallDetailLoadingSuccess extends CandiDateState {
  CallDetailLoadingSuccess({super.callData});
}
/*
class JdDetailState {
  final List<JDData>? listData;
  Job_DetailData? detail;
  final String? error;
   JdDetailState({this.listData, this.error,this.detail});

  JdDetailState copyWith({List<JDData>? listData, String? error,Job_DetailData? detail}) {
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

 */
