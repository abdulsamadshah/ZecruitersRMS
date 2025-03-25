//package com.example.zecruiters_rms
//
//import android.content.Intent
//import android.os.Bundle
//import android.util.Log
//import androidx.annotation.NonNull
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
//
//class MainActivity : FlutterActivity() {
//    private val CHANNEL = "com.example.zecruiters_rms"
//    private var filePath: String = ""
//
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call: MethodCall, result ->
//            when (call.method) {
//                "startCallRecording" -> {
//                    val intent = Intent(this, CallRecordingService::class.java)
//                    startService(intent)
//                    filePath = "${externalCacheDir?.absolutePath}/call_recording.mp4"
//                    Log.d("MainActivity", "Returning file path: $filePath")
//                    result.success(filePath)  // Return the correct file path
//                }
//                "stopCallRecording" -> {
//                    val intent = Intent(this, CallRecordingService::class.java)
//                    stopService(intent)
//                    result.success("Recording Stopped")
//                }
//                else -> result.notImplemented()
//            }
//        }
//    }
//}
package com.example.zecruiters_rms
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.Manifest
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CALL_CHANNEL = "direct_call"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CALL_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "makeDirectCall") {
                val phoneNumber = call.argument<String>("phoneNumber")
                if (phoneNumber != null) {
                    makeDirectCall(phoneNumber)
                    result.success("Call Started")
                } else {
                    result.error("INVALID_NUMBER", "Phone number is required", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun makeDirectCall(phoneNumber: String) {
        val intent = Intent(Intent.ACTION_CALL)
        intent.data = Uri.parse("tel:$phoneNumber")

        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.CALL_PHONE) == PackageManager.PERMISSION_GRANTED) {
            startActivity(intent)
        } else {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CALL_PHONE), 1)
        }
    }
}