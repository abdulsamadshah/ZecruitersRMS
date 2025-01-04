import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phone_state/phone_state.dart';
import 'package:permission_handler/permission_handler.dart';

// class CallHandler {
//   StreamSubscription<PhoneStateStatus>? _subscription;
//   bool _isRecording = false;
//   File? _recordedFile;
//
//   Future<void> startListening() async {
//     final permissionStatus = await Permission.microphone.request();
//     if (!permissionStatus.isGranted) {
//       print("Microphone permission not granted");
//       return;
//     }
//
//     _subscription = PhoneState.phoneStateStream.listen((event) async {
//       if (event == PhoneStateStatus.CALL_STARTED) {
//         print("Call started, starting recording...");
//         await _startRecording();
//       } else if (event == PhoneStateStatus.CALL_ENDED) {
//         print("Call ended, stopping recording...");
//         await _stopRecording();
//       }
//     });
//   }
//
//   Future<void> _startRecording() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = "${directory.path}/call_recording_${DateTime.now().millisecondsSinceEpoch}.m4a";
//     _recordedFile = File(filePath);
//
//     // Simulate recording start
//     _isRecording = true;
//     print("Recording started: $filePath");
//     // Actual recording logic would go here
//   }
//
//   Future<void> _stopRecording() async {
//     if (_isRecording) {
//       // Simulate recording stop
//       _isRecording = false;
//       print("Recording stopped and saved at: ${_recordedFile?.path}");
//       // Actual stop logic would go here
//     }
//   }
//
//   void dispose() {
//     _subscription?.cancel();
//   }
// }
