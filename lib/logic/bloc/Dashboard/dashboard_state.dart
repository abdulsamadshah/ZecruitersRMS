part of 'dashboard_cubit.dart';

@immutable
class DashboardState {
  int selectedIndex;
  DashData? detail;
  final String? error;
  DateTime selectedDate;

  DashboardState({
    this.selectedIndex = 0,
    this.error,
    this.detail,
    DateTime? selectedDate, // Allow null value
  }) : selectedDate = selectedDate ?? DateTime.now(); // ✅ Ensures default value

  DashboardState copyWith({
    int? selectedIndex,
    DashData? detail,
    String? error,
    DateTime? selectedDate, // ✅ Change type from String? to DateTime?
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      error: error ?? this.error,
      detail: detail ?? this.detail,
      selectedDate: selectedDate ?? this.selectedDate, // ✅ No type mismatch
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
