package com.example.vpn_whitexproject_app

import io.flutter.embedding.android.FlutterActivity
import android.app.Application
import android.content.Intent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.channels.Channel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "vpn"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when(call.method) {
                    "startService" -> {
                        startService(Intent(this, MyService::class.java))
                        result.success("Service started")
                    }

                    "stopService" -> {
                        stopService(Intent(this, MyService::class.java))
                        result.success(("Service stopped"))
                    }

                    else -> result.notImplemented()
                }
            }
    }
}