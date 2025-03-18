part of 'dashboard_cubit.dart';

@immutable
class DashboardState {
  int selectedIndex;
  DashData? detail;
  final String? error;
  // DateTime? selectedDate;

  DashboardState({
    this.selectedIndex = 0,
    this.error,
    this.detail,
    // this.selectedDate,
  });

  DashboardState copyWith({
    int? selectedIndex,
    DashData? detail,
    String? error,
    // DateTime? selectedDate,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      error: error ?? this.error,
      detail: detail ?? this.detail,
      // selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

final class DashboardInitial extends DashboardState {}

class LoadingState extends DashboardState {}

class DashboardLoadingSuccess extends DashboardState {
  DashboardLoadingSuccess({super.detail});
}

class LoadingError extends DashboardState {
  LoadingError(String error) : super(error: error);
}
