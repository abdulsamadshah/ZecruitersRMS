import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import 'package:record/record.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/core/constant/Utils.dart';

class RecordCall extends StatefulWidget {
  const RecordCall({super.key});

  @override
  State<RecordCall> createState() => _RecordCallState();
}

class _RecordCallState extends State<RecordCall> {
  StreamSubscription<PhoneState>? _phoneStateSubscription;
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioRecorder _recorder = AudioRecorder();
  String? _filePath;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _listenForCallEvents();
  }

  @override
  void dispose() {
    _phoneStateSubscription?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.microphone,
      Permission.phone,
      Permission.storage,
    ].request();
  }

  Future<void> startRecording() async {
    final Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
    String filePath = p.join(appDocumentDirectory.path, "recording.wav");

    if (await _recorder.hasPermission()) {
      Utils.fluttertoast("🎤 Starting recording...");
      await _recorder.start(
        RecordConfig(),
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
      String? filePath = await _recorder.stop();

      if (filePath != null) {
        setState(() {
          _isRecording = false;
          _filePath = filePath;
        });


        Utils.fluttertoast("📤 Recording stopped and saved at: ${filePath}");
      } else {
        Utils.fluttertoast("❌ Error stopping the recording");
      }
    } catch (e) {
      Utils.fluttertoast("❌ Error stopping recording: $e");
    }
  }



  void _listenForCallEvents() {
    _phoneStateSubscription = PhoneState.stream.listen((PhoneState state) async {
      if (state.status == PhoneStateStatus.CALL_STARTED) {
        await Future.delayed(Duration(milliseconds: 500));
        await startRecording();
      } else if (state.status == PhoneStateStatus.CALL_ENDED) {
        await Future.delayed(Duration(milliseconds: 500));
        await _stopRecording();
      }
    });
  }

  Future<void> _makePhoneCall(String phone) async {
    var url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.fluttertoast("❌ Could not launch dialer");
    }
  }

  Future<void> playRecord() async {
    if (_filePath != null) {
      try {
        final file = File(_filePath!);
        print("Recording file path: $_filePath");

        if (await file.exists()) {
          final fileSize = await file.length();
          if (fileSize > 0) {
            print("File exists and has a valid size: $fileSize bytes");

            // Stop any currently playing audio before starting the new one
            await audioPlayer.stop();

            await audioPlayer.setFilePath(_filePath!);
            await audioPlayer.play();
          } else {
            Utils.fluttertoast("❌ The file is empty: $fileSize bytes");
          }
        } else {
          Utils.fluttertoast("❌ File does not exist at path: $_filePath");
        }
      } catch (e) {
        Utils.fluttertoast("❌ Error playing the recording: $e");
      }
    } else {
      Utils.fluttertoast("❌ No recording found to play");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 50),
            StreamBuilder(
              stream: PhoneState.stream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Text('📞 Phone State not available');
                }

                final status = snapshot.data!.status;
                return Column(
                  children: [
                    const Text('Call Status:', style: TextStyle(fontSize: 24)),
                    Text(
                      '📞 ${status.name}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _makePhoneCall("7387454586"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('📞 Make a Call'),
            ),
            ElevatedButton(
              onPressed: startRecording,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Record'),
            ),
            ElevatedButton(
              onPressed: _stopRecording,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Stop'),
            ),
            ElevatedButton(
              onPressed: playRecord,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Play Record'),
            ),
          ],
        ),
      ),
    );
  }
}
