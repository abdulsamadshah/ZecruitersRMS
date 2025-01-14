part of 'dashboard_cubit.dart';

@immutable
 class DashboardState {
  int selectedIndex;


  DashboardState({this.selectedIndex=0});

  DashboardState copyWith({int? selectedIndex}){
    return DashboardState(selectedIndex: selectedIndex ?? this.selectedIndex,);
  }
}


