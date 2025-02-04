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
import 'package:zecruiters_rms/presentation/common_widget/common_widget.dart';

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
    // _audioPlayer.dispose();
    super.dispose();
  }

  /// Request necessary permissions
  Future<void> _requestPermissions() async {
    await [
      Permission.microphone,
      Permission.phone,
      Permission.storage,
    ].request();
  }

  /// Start recording the call
  Future<void> startRecording() async {
    final Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
    String filePath= p.join(appDocumentDirectory.path,"recording.wav");

    if (await _recorder.hasPermission()) {
      print("🎤 Starting recording...");
      await _recorder.start(
        RecordConfig(),
        path: filePath,
      );
      setState(() {
        _isRecording = true;
        _filePath=null;
      });

    } else {
      Utils.fluttertoast("❌ No recording permission!");
    }
  }




  /// Stop recording the call
  Future<void> _stopRecording() async {
    try {
      String? filePath =   await _recorder.stop();

      if(filePath !=null){
        setState(() {
          _isRecording=false;
          _filePath=filePath;
        });
      }

    } catch (e) {
      Utils.fluttertoast(e.toString());
      print("❌ Error stopping recording: $e");
    }
  }

  /// Play the recorded audio

  Future<void> playRecording() async {
    if (_filePath == null || !File(_filePath!).existsSync()) {
      Utils.fluttertoast("❌ No recorded file found!");
      return;
    }

    try {
      print("🎵 Playing file from: $_filePath");

      await audioPlayer.setFilePath(_filePath!);
       audioPlayer.play();
      setState(() {

      });

      print("🎵 Playing recorded audio...");
    } catch (e) {
      Utils.fluttertoast("❌ Error playing audio: $e");
    }

  }

  /// Handle Call Events
  void _listenForCallEvents() {
    _phoneStateSubscription = PhoneState.stream.listen((PhoneState state) async {
      if (state.status == PhoneStateStatus.CALL_STARTED) {
        await startRecording();
      } else if (state.status == PhoneStateStatus.CALL_ENDED) {
        await _stopRecording();

        if (_filePath != null) {
          Utils.fluttertoast("📤 Uploading recording to server...");
          // uploadRecording(_filePath.toString()); // Uncomment when implementing upload
        } else {
          Utils.fluttertoast("❌ File path is empty");
        }
      }
    });
  }

  /// Initiate a phone call
  Future<void> _makePhoneCall(String phone) async {
    var url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.fluttertoast("❌ Could not launch dialer");
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
            if(_filePath != null)
            ElevatedButton(
              onPressed: () {
                if (_filePath == null || _filePath!.isEmpty) {
                  Utils.fluttertoast("❌ File path is empty");
                } else {
                  playRecording();
                }
              },
              child: const Text('▶️ Play Recording'),
            ),

            if(_filePath == null)
              reausabletext("No Recording found"),


            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _makePhoneCall("7387454586"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('📞 Make a Call'),
            ),
          ],
        ),
      ),
    );
  }
}
