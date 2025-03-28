import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:record/record.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/core/constant/Dialog.dart';
import 'package:zecruiters_rms/core/constant/Utils.dart';
import 'package:zecruiters_rms/core/theme/themes_data.dart';
import 'package:zecruiters_rms/data/models/CandiDateDetailRes.dart';
import 'package:zecruiters_rms/gen/fonts.gen.dart';
import 'package:zecruiters_rms/logic/bloc/CandiDate/candi_date_cubit.dart';
import 'package:zecruiters_rms/presentation/screen/Widget/CandiDate_widget.dart';

import '../../../../data/models/CallDetailRes.dart';
import '../../../common_widget/common_widget.dart';

class CandidateDetailScreen extends StatefulWidget {
  String jdId, candiDateId, mobNo;

  CandidateDetailScreen(
      {Key? key,
      required this.jdId,
      required this.candiDateId,
      required this.mobNo})
      : super(key: key);

  @override
  State<CandidateDetailScreen> createState() => _CandidateDetailScreenState();
}

class _CandidateDetailScreenState extends State<CandidateDetailScreen> {
  final CandiDateCubit RemarksCubit = CandiDateCubit();
  final CandiDateCubit candiDateCubit = CandiDateCubit();
  final CandiDateCubit callDetailCubit = CandiDateCubit();

  StreamSubscription<PhoneState>? _phoneStateSubscription;
  final AudioPlayer audioPlayer = AudioPlayer();


  bool granted = false;
  var isCallOngoing = false;
var callStartTime;
var callEndtTime;
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

    candiDateCubit.getCandidateDetailData(
        jdid: widget.jdId,
        candidateid: widget.candiDateId,
        remarkList: RemarksCubit);
    callDetailCubit.getCallDataList(jdId: widget.jdId, mobNo: widget.mobNo);
    _requestPermissions();
    _listenForCallEvents();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _phoneStateSubscription?.cancel();
    audioPlayer.dispose();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.microphone,
      Permission.phone,
      Permission.storage,
    ].request();
  }




  bool _isCallLogSaved = false; // Add this flag

  void _listenForCallEvents() {
    _phoneStateSubscription?.cancel();
    _phoneStateSubscription = PhoneState.stream.listen((PhoneState state) async {


      if (state.status == PhoneStateStatus.CALL_STARTED) {

        if (callStartTime == null) {
          callStartTime = DateTime.now();
        }




        _isCallLogSaved = false;

      } else if (state.status == PhoneStateStatus.CALL_ENDED) {
        if (!_isCallLogSaved) {
          _isCallLogSaved = true;
          callEndtTime = DateTime.now();
          _saveAndSendCallLog();
        }
      }
    });
  }




  Future<void> _saveAndSendCallLog() async {
    if (callStartTime != null && callEndtTime != null) {

      Duration callDuration = callEndtTime!.difference(callStartTime!);

      String formattedStartTime = candiDateCubit.formatTime(callStartTime!);
      String formattedEndTime = candiDateCubit.formatTime(callEndtTime!);
      String formattedDuration = candiDateCubit.formatDuration(callDuration);



      Map<String, dynamic> callLog = {
        "call_start_time": candiDateCubit.formatTime(callStartTime!), // Format as needed
        "call_end_time": candiDateCubit.formatTime(callEndtTime!),     // Format as needed
        "call_duration": formattedDuration // Example: "04:31:30"
      };

      // print("📡 Sending Data to API: $callLog");

      log("Start Time:${callStartTime},,,,,${callEndtTime}");
      RemarksCubit.CallPostRecore(context,
          callLog: callLog,
          cubit: RemarksCubit,

          jdId: candiDateCubit.state.detail!.jdId.toString(),
          mobNo: candiDateCubit.state.detail!.contactNo.toString(),
          candidateid: widget.candiDateId, RecordCallBack: (success) {
        if (success) {

          callDetailCubit.getCallDataList(jdId: widget.jdId, mobNo: widget.mobNo);
          callStartTime=null;

        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
          appBar: mainAppBar(context, title: widget.candiDateId, type: "basic"),
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
                      final networkconnectionlost = state as LoadingError;
                      return SizedBox();

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
          )),
      create: (context) => RemarksCubit,);
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
                          mobNo: detail!.contactNo.toString(),
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
                buildDetailRow("Remarks", detail?.remarkst ?? "N/A"),
                buildDetailRow(
                  "Total Call Duration",
                 detail?.totalCallDuration.toString() ?? "",
                ),
                const Divider(),

                // Call Recording functionality
                //  StreamBuilder(
                //    stream: PhoneState.stream,
                //    builder: (context, snapshot) {
                //      PhoneState? status = snapshot.data;
                //      if (status == null) {
                //        return const Text(
                //          'Phone State not available',
                //        );
                //      }
                //      return Column(
                //        children: [
                //          const Text(
                //            'Status of call',
                //            style: TextStyle(fontSize: 24),
                //          ),
                //          if (status.status == PhoneStateStatus.CALL_INCOMING ||
                //              status.status == PhoneStateStatus.CALL_STARTED)
                //            Text(
                //              'Number: ${status.number}',
                //              style: const TextStyle(fontSize: 24),
                //            ),
                //          if (status.duration != null)
                //            Text(
                //              'Duration of call: ${_formatDuration(status.duration!)}',
                //              style: const TextStyle(fontSize: 24),
                //            ),
                //          Icon(
                //            getIcons(status.status),
                //            color: getColor(status.status),
                //            size: 80,
                //          )
                //        ],
                //      );
                //    },
                //  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildIconButton(
                      icon: Icons.call,
                      color: Colors.green,
                      onTap: () async {
                        candiDateCubit.makePhoneCall(detail!.contactNo.toString());
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

                        String url = "https://wa.me/${detail?.contactNo ?? ""}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not open WhatsApp.';
                        }
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

  Widget CallListUi({List<CallDetail>? data, bool isLoading = false}) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data?.length ?? 0,
        itemBuilder: (ctx, index) {
          final callDetail = data?[index];

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            child: Card(
              elevation: 5,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Call Record Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.phone, color: Colors.green, size: 32.r),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextRow('Mobile', callDetail?.mobileNo),
                              _buildTextRow(
                                'Call Duration',
                                callDetail?.callDuration ?? "00:00",
                              ),
                              _buildTextRow(
                                'Call By',
                                callDetail?.callBy ?? "N/A",
                              ),
                              _buildTextRow(
                                'Date & Time',
                                callDetail?.dateTime ?? "N/A",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextRow(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
