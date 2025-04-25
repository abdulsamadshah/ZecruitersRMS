import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/data/Services/CallHelper.dart';
import 'package:zecruiters_rms/data/models/CandiDateDetailRes.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:zecruiters_rms/logic/bloc/CandiDate/candi_date_cubit.dart';
import 'package:zecruiters_rms/presentation/screen/Widget/CandiDate_widget.dart';
import 'package:zecruiters_rms/presentation/screen/Widget/JD_Widget.dart';

import '../../../common_widget/common_widget.dart';

class CandidateDetailScreen extends StatefulWidget {
  final String jdId, candiDateId, mobNo;

  CandidateDetailScreen(
      {Key? key,
      required this.jdId,
      required this.candiDateId,
      required this.mobNo})
      : super(key: key);

  @override
  State<CandidateDetailScreen> createState() => _CandidateDetailScreenState();
}

class _CandidateDetailScreenState extends State<CandidateDetailScreen>
    with WidgetsBindingObserver {
  final CandiDateCubit RemarksCubit = CandiDateCubit();
  final CandiDateCubit candiDateCubit = CandiDateCubit();
  final CandiDateCubit callDetailCubit = CandiDateCubit();

  StreamSubscription<PhoneState>? _phoneStateSubscription;
  bool granted = false;
  bool isCallOngoing = false;
  var callStartTime;
  var callEndtTime;
  bool _isCallLogSaved = false;
  Timer? _timer;
  int elapsedTimeInSeconds = 0;
  var phoneNumber = '';

  IconData getIcons(PhoneStateStatus status) {
    return switch (status) {
      PhoneStateStatus.NOTHING => Icons.clear,
      PhoneStateStatus.CALL_INCOMING => Icons.add_call,
      PhoneStateStatus.CALL_STARTED => Icons.call,
      PhoneStateStatus.CALL_ENDED => Icons.call_end,
    };
  }

  Color getColor(PhoneStateStatus status) {
    return switch (status) {
      PhoneStateStatus.NOTHING || PhoneStateStatus.CALL_ENDED => Colors.red,
      PhoneStateStatus.CALL_INCOMING => Colors.green,
      PhoneStateStatus.CALL_STARTED => Colors.orange,
    };
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    candiDateCubit.getCandidateDetailData(
        jdid: widget.jdId,
        candidateid: widget.candiDateId,
        remarkList: RemarksCubit);
    callDetailCubit.getCallDataList(jdId: widget.jdId, mobNo: widget.mobNo);
    _requestPermissions();
    _listenForCallEvents();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _phoneStateSubscription?.cancel();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.microphone,
      Permission.phone,
      Permission.storage,
    ].request();
  }

  void _listenForCallEvents() {
    _phoneStateSubscription?.cancel();
    _phoneStateSubscription =
        PhoneState.stream.listen((PhoneState state) async {
      if (state.status == PhoneStateStatus.CALL_STARTED) {
        callStartTime ??= DateTime.now();
        _isCallLogSaved = false;
      } else if (state.status == PhoneStateStatus.CALL_ENDED) {
        if (!_isCallLogSaved) {
          callEndtTime = DateTime.now();
          _saveAndSendCallLog();
          _isCallLogSaved = true;
        }
      }
    });
  }

  Future<void> _saveAndSendCallLog() async {
    if (callStartTime != null && callEndtTime != null) {
      Duration callDuration = callEndtTime!.difference(callStartTime!);
      String formattedDuration = candiDateCubit.formatDuration(callDuration);

      Map<String, dynamic> callLog = {
        "call_start_time": candiDateCubit.formatTime(callStartTime!),
        "call_end_time": candiDateCubit.formatTime(callEndtTime!),
        "call_duration": formattedDuration
      };

      log("Saving Call Log - Start: $callStartTime, End: $callEndtTime, Duration: $formattedDuration");

      RemarksCubit.CallPostRecore(
        context,
        callLog: callLog,
        cubit: RemarksCubit,
        jdId: candiDateCubit.state.detail?.jdId.toString() ?? "",
        mobNo: candiDateCubit.state.detail?.contactNo.toString() ?? "",
        candidateid: widget.candiDateId,
        RecordCallBack: (success) {
          if (success) {
            callDetailCubit.getCallDataList(
                jdId: widget.jdId, mobNo: widget.mobNo);
            callStartTime = null;
            callEndtTime = null;
            _isCallLogSaved = false;
          } else {
            log("Call log save failed.");
          }
        },
      );
    } else {
      log("Call start or end time is null. Start: $callStartTime, End: $callEndtTime");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      log("App resumed. Refreshing call data.");
      callDetailCubit.getCallDataList(jdId: widget.jdId, mobNo: widget.mobNo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: BlocProvider(
        create: (context) => RemarksCubit,
        child: Scaffold(
          appBar: mainAppBar(context,
              title: widget.candiDateId, type: "basic", popValue: true),
          body: ListView(
            children: [
              BlocConsumer<CandiDateCubit, CandiDateState>(
                bloc: candiDateCubit,
                listener: (context, state) {},
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LoadingState:
                      return CandiDateDetailUi(isLoading: true);

                    case LoadingError:
                      final networkconnectionlost = state as LoadingError;
                      return LostinternetConnection(
                          retry: () {
                            candiDateCubit.getCandidateDetailData(
                                jdid: widget.jdId,
                                candidateid: widget.candiDateId,
                                remarkList: RemarksCubit);
                          },
                          messgae: networkconnectionlost.error.toString());

                    case CandiDateDetailLoadingSuccess:
                      final list = state as CandiDateDetailLoadingSuccess;
                      if (list.detail == null) {
                        return Align(
                            alignment: Alignment.center,
                            child: reausabletext("No Data Found"));
                      } else {
                        return CandiDateDetailUi(detail: list.detail);
                      }

                    default:
                      return const SizedBox();
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: reausabletext("Call Detail",
                    fontsize: 21, fontweight: FontWeight.bold),
              ),
              BlocConsumer<CandiDateCubit, CandiDateState>(
                bloc: callDetailCubit,
                listener: (context, state) {},
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case LoadingState:
                      return CallListUi(isLoading: true);

                    case LoadingError:
                      return const SizedBox();

                    case CallDetailLoadingSuccess:
                      final list = state as CallDetailLoadingSuccess;
                      if (list.callData!.isEmpty) {
                        return Align(
                            alignment: Alignment.center,
                            child: reausabletext("No Call Data Found"));
                      } else {
                        return CallListUi(data: list.callData);
                      }

                    default:
                      return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CandiDateDetailUi({CandiDateDetail? detail, bool isLoading = false}) {
    return Skeletonizer(
      enabled: isLoading,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${detail?.firstName ?? ""} ${detail?.lastName ?? ""}",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            detail?.emailId ?? "No email provided",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        RemarksCubit.getReMarkList(
                          context,
                          cubit: RemarksCubit,
                          jdId: detail!.jdId.toString(),
                          mobNo: detail.contactNo.toString(),
                          candidateid: widget.candiDateId,
                          RemarkCallBack: (success) {
                            if (success) {
                              candiDateCubit.getCandidateDetailData(
                                  jdid: widget.jdId,
                                  candidateid: widget.candiDateId,
                                  remarkList: RemarksCubit);
                            }
                          },
                        );
                      },
                      child: reausabletext("Edit",
                          fontfamily: FontFamily.interSemiBold,
                          color: ToggleThemeData.Appcolor,
                          decorattion: TextDecoration.underline,
                          fontsize: 19),
                    ),
                  ],
                ),
                const Divider(),
                // Contact Details Section
                buildDetailRow("JD ID", detail?.jdId ?? "N/A"),
                buildDetailRow("Mobile", detail?.contactNo ?? "N/A"),
                buildDetailRow("Gender", detail?.gender ?? "N/A"),
                detail?.remarkst == ''
                    ? const SizedBox()
                    : buildDetailRow("Remarks", detail?.remarkst ?? "N/A"),
                detail?.remarks == ""
                    ? const SizedBox()
                    : buildDetailRow("Comment", detail?.remarks ?? "N/A"),
                buildDetailRow(
                  "Total Call Duration",
                  detail?.totalCallDuration?.toString() ?? "N/A",
                ),

                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildIconButton(
                      icon: Icons.call,
                      color: Colors.green,
                      onTap: () async {
                        candiDateCubit
                            .makePhoneCall(detail!.contactNo.toString());
                      },
                    ),
                    buildIconButton(
                      icon: Icons.email,
                      color: Colors.blue,
                      onTap: () async {
                        String url = "mailto:${detail?.emailId ?? ""}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not send the email.';
                        }
                      },
                    ),
                    buildIconButton(
                      icon: FontAwesomeIcons.whatsapp,
                      color: Colors.teal,
                      onTap: () async {
                        CallHelper().launchWhatsAppChooser(
                            "${detail?.contactNo}"); // your phone number
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
