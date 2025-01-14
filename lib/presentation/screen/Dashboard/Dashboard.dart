import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/logic/bloc/Dashboard/dashboard_cubit.dart';

import 'Home.dart';

class DashboardScreen extends StatefulWidget {
  @override
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  final List<Widget> _pages = [
    const Home(),
    const Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) => Scaffold(
        body: _pages[state.selectedIndex],
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.r),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(20.r), // Rounded corners
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: GNav(
                gap: 8,
                activeColor: Colors.white,
                color: Colors.grey,
                backgroundColor: Colors.black,
                tabBackgroundColor: ToggleThemeData.Appcolor,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                tabs: const [
                  GButton(
                    icon: Icons.work_outline,
                    text: 'JD',
                    iconColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                    iconColor: Colors.white,
                  ),
                ],
                selectedIndex: state.selectedIndex,
                onTabChange: (index) {
                  context.read<DashboardCubit>().changeIndex(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
