package com.example.zecruiters_rms

import android.app.Service
import android.content.Intent
import android.media.MediaRecorder
import android.os.Environment
import android.os.IBinder
import android.util.Log
import java.io.File

class CallRecordingService : Service() {
    private var mediaRecorder: MediaRecorder? = null
    private var filePath: String = ""

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        filePath = "${externalCacheDir?.absolutePath}/call_recording.mp4"

        Log.d("CallRecording", "Saving to: $filePath")
        startRecording()

        return START_STICKY
    }

    private fun startRecording() {
        try {
            mediaRecorder = MediaRecorder().apply {
                setAudioSource(MediaRecorder.AudioSource.VOICE_COMMUNICATION)
                setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
                setAudioEncoder(MediaRecorder.AudioEncoder.AAC)
                setOutputFile(filePath)
                prepare()
                start()
            }
            Log.d("CallRecording", "Recording started successfully at: $filePath")
        } catch (e: Exception) {
            Log.e("CallRecording", "Error starting recording: ${e.message}")
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        stopRecording()
    }

    private fun stopRecording() {
        try {
            mediaRecorder?.apply {
                stop()
                release()
            }
            mediaRecorder = null
            Log.d("CallRecording", "Recording stopped. File saved at: $filePath")
        } catch (e: Exception) {
            Log.e("CallRecording", "Error stopping recording: ${e.message}")
        }
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
}
