

import 'package:zecruiters_rms/core/Utils/Context_Utility.dart';
import 'package:zecruiters_rms/logic/bloc/SignIn/sign_in_bloc.dart';
import 'package:zecruiters_rms/logic/bloc/jd_detail_cubit.dart';
import 'package:zecruiters_rms/presentation/screen/Application/splashscreen.dart';
import 'package:zecruiters_rms/presentation/screen/Auth/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zecruiters_rms/presentation/screen/Dashboard/Dashboard.dart';
import 'package:zecruiters_rms/presentation/screen/Detail/JobDetailScreen.dart';
import 'package:zecruiters_rms/presentation/screen/Detail/MisDetailScreen.dart';

import 'app_route_constants.dart';

class MyAppRouter {
  final GoRouter router;

  MyAppRouter()
      : router = GoRouter(
          navigatorKey: ContextUtility.navigatorkey,
          routes: [
            GoRoute(
              name: MyAppRouteConstants.splashscreen,
              path: '/',
              pageBuilder: (context, state) {
                return const MaterialPage(child: Splashscreen());
              },
            ),
            GoRoute(
              name: MyAppRouteConstants.loginScreen,
              path: '/LoginScreen',
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: BlocProvider(
                    create: (context) => SignInBloc(),
                    child: const LoginScreen(),
                  ),
                );
              },
            ),

            GoRoute(
              name: MyAppRouteConstants.dashBoardScreen,
              path: '/Dashboard',
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: const Dashboard(),
                );
              },
            ),

            GoRoute(
              name: MyAppRouteConstants.JobdetailScreen,
              path: '/Jobdetail',
              pageBuilder: (context, state) {
                return MaterialPage(
                  child: BlocProvider(
                    create: (context) => JdDetailCubit(),
                    child: const JobDetail(),
                  ),
                );

                //   const MaterialPage(
                //   child: JobDetail(),
                // );
              },
            ),


            GoRoute(
              name: MyAppRouteConstants.Misdetailscreen,
              path: '/Misdetail',
              pageBuilder: (context, state) {
                return const MaterialPage(
                  child: Misdetailscreen(),
                );
              },
            ),


          ],
          errorPageBuilder: (context, state) {
            return const MaterialPage(child: Text("No Routes Found"));
          },
          redirect: (context, state) {
            // Handle redirects if needed
            return null;
          },
        );
}
