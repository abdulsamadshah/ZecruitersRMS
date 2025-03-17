import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  static const platform = MethodChannel('com.example.zecruiters_rms');
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? recordedFilePath;
  bool isCallAccepted = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.microphone.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> _acceptCall() async {
    try {
      final String filePath = await platform.invokeMethod('startCallRecording');
      setState(() {
        recordedFilePath = filePath; // Ensure we get the correct file path
        isCallAccepted = true;
      });
      print("Call accepted. Recording started. File saved at: $filePath");
    } on PlatformException catch (e) {
      print("Error starting call recording: '${e.message}'");
    }
  }

  Future<void> _playRecording() async {
    if (recordedFilePath == null || recordedFilePath!.isEmpty) {
      print("No recorded file found!");
      return;
    }

    // Check if file actually exists
    File recordedFile = File(recordedFilePath!);
    if (!await recordedFile.exists()) {
      print("File does not exist at path: $recordedFilePath");
      return;
    }

    try {
      await _audioPlayer.setFilePath(recordedFilePath!);
      await _audioPlayer.play();
      print("Playing audio: $recordedFilePath");
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> _endCall() async {
    try {
      await platform.invokeMethod('stopCallRecording');
      setState(() {
        isCallAccepted = false;
      });
      print("Call ended. Recording stopped.");
    } on PlatformException catch (e) {
      print("Error stopping call recording: '${e.message}'");
    }
  }

  Future<void> makePhoneCall(String phone) async {
    var url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
      print("Calling... Waiting for acceptance.");
      setState(() {
        isCallAccepted = false;
      });
    } else {
      print("Could not launch dialer");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Call Recorder")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                makePhoneCall("7387454586");
              },
              child: Text("Start Call"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _acceptCall,
              child: Text("Accept Call (Start Recording)"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _endCall,
              child: Text("End Call"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _playRecording,
              child: Text("Play Recording"),
            ),
          ],
        ),
      ),
    );
  }
}
