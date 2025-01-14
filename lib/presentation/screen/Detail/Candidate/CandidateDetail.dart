import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/core/common_widget/appBar.dart';
import 'package:zecruiters_rms/core/constant/Utils.dart';
import 'package:zecruiters_rms/data/models/CandiDateDetailRes.dart';
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
  final CandiDateCubit candiDateCubit = CandiDateCubit();
  final CandiDateCubit callDetailCubit = CandiDateCubit();
  StreamSubscription<PhoneStateStatus>? _phoneStateSubscription;

  bool granted = false;
  var isCallOngoing = false;
  DateTime? callStartTime;
  Timer? _timer;
  int elapsedTimeInSeconds = 0;
  var phoneNumber = '';
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours =
    duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : '';
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours$minutes:$seconds';
  }

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


  Future<void> makePhoneCall(String phone) async {
    phoneNumber = phone;
    setState(() {

    });

    bool? callResult =
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);

    if (callResult == null || !callResult) {
     Utils.fluttertoast(
       "Failed to initiate phone call");
      return;
    }
  }


  Future<bool> requestPermission() async {
    var status = await Permission.phone.request();

    return switch (status) {
      PermissionStatus.denied ||
      PermissionStatus.restricted ||
      PermissionStatus.limited ||
      PermissionStatus.permanentlyDenied =>
      false,
      PermissionStatus.provisional || PermissionStatus.granted => true,
    };
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
    candiDateCubit.getCandidateDetailData(
        jdid: widget.jdId, candidateid: widget.candiDateId);
    callDetailCubit.getCallDataList(jdId: widget.jdId, mobNo: widget.mobNo);
  }

  @override
  void onClose() {
    _timer?.cancel();
    _phoneStateSubscription?.cancel();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              candidateid: widget.candiDateId);
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
                    return LostinternetConnection(
                        retry: () {
                          callDetailCubit.getCallDataList(
                              jdId: widget.jdId, mobNo: widget.mobNo);
                        },
                        messgae: networkconnectionlost.error.toString());

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
        ));
  }


  Widget CandiDateDetailUi({ CandiDateDetail? detail,
   bool isLoading=false}){
    return Skeletonizer(
      enabled: isLoading,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundColor: Colors.indigo.shade100,
                      child: Text(
                        getInitials(detail: detail),
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
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
                  ],
                ),
                const Divider(),
                // Contact Details Section
                buildDetailRow("JD ID", detail?.jdId ?? "N/A"),
                buildDetailRow("Mobile", detail?.contactNo ?? "N/A"),
                buildDetailRow("Gender", detail?.gender ?? "N/A"),
                buildDetailRow("Remarks", detail?.remarks ?? "N/A"),
                buildDetailRow(
                  "Total Call Duration",
                  formatCallDuration(detail?.totalCallDuration ?? "00:00:00"),
                ),
                const Divider(),
                StreamBuilder(
                  stream: PhoneState.stream,
                  builder: (context, snapshot) {
                    PhoneState? status = snapshot.data;
                    if (status == null) {
                      return Text(
                        'Phone State not available',
                      );
                    }
                    return Column(
                      children: [
                        const Text(
                          'Status of call',
                          style: TextStyle(fontSize: 24),
                        ),
                        if (status.status == PhoneStateStatus.CALL_INCOMING ||
                            status.status == PhoneStateStatus.CALL_STARTED)
                          Text(
                            'Number: ${status.number}',
                            style: const TextStyle(fontSize: 24),
                          ),
                        if (status.duration != null)
                          Text(
                            'Duration of call: ${_formatDuration(status.duration!)}',
                            style: const TextStyle(fontSize: 24),
                          ),
                        Icon(
                          getIcons(status.status),
                          color: getColor(status.status),
                          size: 80,
                        )
                      ],
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildIconButton(
                      icon: Icons.call,
                      color: Colors.green,
                      onTap: () async {
                        makePhoneCall("7387454586");

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
                        String url =
                            "https://wa.me/${detail?.contactNo ?? ""}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not open WhatsApp.';
                        }
                      },
                    ),
                  ],
                ),
                // _buildActionButtons(context, detail: detail),
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
              elevation: 6,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
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
