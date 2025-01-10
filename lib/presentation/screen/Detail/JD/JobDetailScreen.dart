import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skeletonizer/skeletonizer.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';

import 'package:zecruiters_rms/logic/bloc/jd_detail_cubit.dart';
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';
import 'package:zecruiters_rms/presentation/screen/Widget/JD_Widget.dart';

class Jobdetailscreen extends StatefulWidget {
  String jdId;
  Jobdetailscreen({super.key, required this.jdId});

  @override
  State<Jobdetailscreen> createState() => _JobdetailscreenState();
}

class _JobdetailscreenState extends State<Jobdetailscreen> {
  final JdDetailCubit jdDetail = JdDetailCubit();

  @override
  void initState() {
    jdDetail.getJDDetailData(jdid: widget.jdId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: mainAppBar(context, title: widget.jdId, type: "basic"),
        body: BlocConsumer<JdDetailCubit, JdDetailState>(
          bloc: jdDetail,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case LoadingState:
                return JobDetailUi(isLoading: true);

              case LoadingError:
                final networkconnectionlost = state as LoadingError;
                return LostinternetConnection(
                    retry: () {
                      jdDetail.getJDListData();
                    },
                    messgae: networkconnectionlost.error.toString());

              case JobDetailLoadingSuccess:
                final list = state as JobDetailLoadingSuccess;
                if (list.detail == null) {
                  return Align(
                      alignment: Alignment.center,
                      child: reausabletext("No Data Found"));
                } else {
                  return JobDetailUi(detail: list.detail);
                }

              default:
                return const SizedBox();
            }
          },
        ));
  }
}
