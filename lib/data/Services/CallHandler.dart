// import 'package:path_provider/path_provider.dart';
// import 'package:phone_state/phone_state.dart';
// import 'package:record/record.dart';
//
// class CallRecorder {
//
//
//   Future<void> startRecording() async {
//     final directory = await getApplicationDocumentsDirectory();
//     _filePath = '${directory.path}/call_recording.aac';
//
//     // Ensure the path is being set correctly before starting
//     print("Recording will be saved at: $_filePath");
//
//     // Start recording
//     await _recorder.start(const RecordConfig(), path: _filePath.toString());
//     _isRecording = true;
//     print("🎤 Recording Started...");
//   }
//
//   Future<void> stopRecording() async {
//     // Stop recording and get the file path
//     String? path = await _recorder.stop();
//
//     // Log and check if the path is returned correctly
//     if (path != null) {
//       _isRecording = false;
//       _filePath = path;
//       print("🛑 Recording Stopped. File saved at: $_filePath");
//     } else {
//       print("❌ Error: No file path returned. Stop recording might have failed.");
//     }
//   }
//
//   String? getFilePath() => _filePath;
// }
//
// CallRecorder callRecorder = CallRecorder();
//
// void listenForCallEvents() {
//   PhoneState.stream.listen((PhoneState state) async {
//     if (state.status == PhoneStateStatus.CALL_STARTED) {
//       print("📞 Call Started...");
//       await callRecorder.startRecording();
//     } else if (state.status == PhoneStateStatus.CALL_ENDED) {
//       print("🔴 Call Ended...");
//       await callRecorder.stopRecording();
//
//       // Log the file path before proceeding with upload
//       String? filePath = callRecorder.getFilePath();
//       if (filePath != null) {
//         print("File path retrieved: $filePath");
//         uploadRecording(filePath);
//       } else {
//         print("❌ Failed to get file path after recording.");
//       }
//     }
//   });
// }
//
// Future<void> uploadRecording(String filePath) async {
//   print("Uploading file: $filePath");
//
//   // Additional logic for uploading the file goes here
// }
