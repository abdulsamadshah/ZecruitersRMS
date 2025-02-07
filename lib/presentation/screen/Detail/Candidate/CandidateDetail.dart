import 'dart:async';
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

  StreamSubscription<PhoneState>? _phoneStateSubscription;
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioRecorder _recorder = AudioRecorder();
  String? _filePath;
  bool _isRecording = false;

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

  @override
  void initState() {
    super.initState();

    candiDateCubit.getCandidateDetailData(
        jdid: widget.jdId, candidateid: widget.candiDateId);
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

  Future<void> startRecording() async {
    final Directory appDocumentDirectory =
        await getApplicationDocumentsDirectory();
    String filePath = p.join(appDocumentDirectory.path, "recording.wav");

    if (await _recorder.hasPermission()) {
      Utils.fluttertoast("🎤 Starting recording...");
      await _recorder.start(
        RecordConfig(
          encoder: AudioEncoder.wav,
          // sampleRate: 16000,
          // bitRate: 128000,
          noiseSuppress: true, // ✅ Helps in call recording
          // androidOutputFormat: AndroidAudioSource.voiceCommunication, // ✅ Ensures capturing call audio
        ),
        path: filePath,
      );
      setState(() {
        _isRecording = true;
        _filePath = filePath;
      });
    } else {
      Utils.fluttertoast("❌ No recording permission!");
    }
  }

  Future<void> _stopRecording() async {
    if (!_isRecording) return;

    try {
      await Future.delayed(Duration(milliseconds: 500)); // ✅ Ensures recording finishes
      String? filePath = await _recorder.stop();

      if (filePath != null) {
        final fileSize = await File(filePath).length();

        setState(() {
          _isRecording = false;
          _filePath = filePath;
        });

        if (fileSize > 0) {
          Utils.fluttertoast("✅ Recording saved at: ${filePath} (Size: $fileSize bytes)");
        } else {
          Utils.fluttertoast("❌ Recording file is empty! Try another source.");
        }
      } else {
        Utils.fluttertoast("❌ Error stopping the recording");
      }
    } catch (e) {
      Utils.fluttertoast("❌ Error stopping recording: $e");
    }
  }




  void _listenForCallEvents() {
    _phoneStateSubscription = PhoneState.stream.listen((PhoneState state) async {
      if (state.status == PhoneStateStatus.CALL_STARTED && !_isRecording) {
        _isRecording = true;
        await startRecording();
        setState(() {

        });
      } else if (state.status == PhoneStateStatus.CALL_ENDED && _isRecording) {
        _isRecording = false;
        await _stopRecording();
        setState(() {

        });
      }
    });
  }

  Future<void> playRecord() async {
    if (_filePath == null || _filePath!.isEmpty) {
      Utils.fluttertoast("❌ No recording found to play");
      return;
    }

    final file = File(_filePath!);

    // 🔹 Step 1: Check if the file exists
    if (!await file.exists()) {
      Utils.fluttertoast("❌ File does not exist at path: $_filePath");
      return;
    }

    // 🔹 Step 2: Check if file has valid size
    final fileSize = await file.length();
    if (fileSize == 0) {
      Utils.fluttertoast("❌ The file is empty, it might be corrupted.");
      return;
    }

    try {
      // 🔹 Step 3: Check if audio format is supported
      if (!_filePath!.endsWith('.wav') && !_filePath!.endsWith('.mp3')) {
        Utils.fluttertoast("❌ Unsupported file format! Only .wav and .mp3 are supported.");
        return;
      }

      Utils.fluttertoast("✅ File is valid. Size: $fileSize bytes");

      // // 🔹 Step 4: Stop any currently playing audio
      // await audioPlayer.stop();

      // 🔹 Step 5: Try setting the file path for playback
      await audioPlayer.setFilePath(_filePath!);

      // 🔹 Step 6: Play the audio
      Utils.fluttertoast("▶️ Playing recording...");
      await audioPlayer.play();
    } catch (e) {
      Utils.fluttertoast("❌ Error playing the recording: $e");
    }
  }


  Future<void> makePhoneCall(String phone) async {
    var url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.fluttertoast("❌ Could not launch dialer");
    }
  }



  // Future<void> playRecord() async {
  //   if (_filePath != null) {
  //     try {
  //       final file = File(_filePath!);
  //       print("Recording file path: $_filePath");
  //
  //       if (await file.exists()) {
  //         final fileSize = await file.length();
  //         if (fileSize > 0) {
  //           Utils.fluttertoast("File exists and has a valid size: $fileSize bytes");
  //
  //           await audioPlayer.stop();
  //           Utils.fluttertoast("Start Playing...");
  //
  //           await audioPlayer.setFilePath(_filePath!);
  //           await audioPlayer.play();
  //         } else {
  //           Utils.fluttertoast("❌ The file is empty: $fileSize bytes");
  //         }
  //       } else {
  //         Utils.fluttertoast("❌ File does not exist at path: $_filePath");
  //       }
  //     } catch (e) {
  //       Utils.fluttertoast("❌ Error playing the recording: $e");
  //     }
  //   } else {
  //     Utils.fluttertoast("❌ No recording found to play");
  //   }
  // }


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
                  ],
                ),
                const Divider(),
                // Contact Details Section
                buildDetailRow("JD ID", detail?.jdId ?? "N/A"),
                buildDetailRow("Mobile", detail?.contactNo ?? "N/A"),
                buildDetailRow("Gender", detail?.gender ?? "N/A"),
                buildDetailRow("Remarks", detail?.remarks ?? "N/A"),
                buildDetailRow("Total Call Duration", formatCallDuration(detail?.totalCallDuration ?? "00:00:00"),),
                const Divider(),

                StreamBuilder(
                  stream: PhoneState.stream,
                  builder: (context, snapshot) {
                    PhoneState? status = snapshot.data;
                    if (status == null) {
                      return const Text(
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
                        // startRecording();
                        makePhoneCall("7387454586");
                      },
                    ),
                    buildIconButton(
                      icon: Icons.email,
                      color: Colors.blue,
                      onTap: () async {
                        _stopRecording();
                        // String url = "mailto:${detail?.emailId ?? ""}";
                        // if (await canLaunch(url)) {
                        //   await launch(url);
                        // } else {
                        //   throw 'Could not send the email.';
                        // }
                      },
                    ),
                    buildIconButton(
                      icon: FontAwesomeIcons.whatsapp,
                      color: Colors.teal,
                      onTap: () async {
                        startRecording();
                        // String url = "https://wa.me/${detail?.contactNo ?? ""}";
                        // if (await canLaunch(url)) {
                        //   await launch(url);
                        // } else {
                        //   throw 'Could not open WhatsApp.';
                        // }
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    playRecord();
                  }, // Play button only if file exists
                  child: const Text('Play Recording'),
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
