package app.whitexproject.vpn

import android.app.Activity
import android.content.Intent
import android.net.VpnService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import xraymobile.Xraymobile as Xray

class MainActivity : FlutterActivity() {

    companion object {
        const val CHANNEL = "vpn"
        const val VPN_REQUEST_CODE = 1001
    }

    private var pendingResult: MethodChannel.Result? = null
    private var pendingConfig: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startService" -> {
                        val config = call.arguments as? String ?: "{}"
                        startVpn(config, result)
                    }
                    "stopService" -> {
                        stopVpn()
                        result.success("Service stopped")
                    }
                    "isRunning" -> {
                        result.success(Xray.isRunning())
                    }
                    "getVersion" -> {
                        result.success(Xray.getVersion())
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun startVpn(config: String, result: MethodChannel.Result) {
        val intent = VpnService.prepare(this)
        if (intent != null) {
            pendingResult = result
            pendingConfig = config
            startActivityForResult(intent, VPN_REQUEST_CODE)
        } else {
            launchVpnService(config)
            result.success("Service started")
        }
    }

    private fun stopVpn() {
        val intent = Intent(this, XrayVpnService::class.java)
        intent.action = XrayVpnService.ACTION_STOP
        startService(intent)
    }

    private fun launchVpnService(config: String) {
        val intent = Intent(this, XrayVpnService::class.java)
        intent.action = XrayVpnService.ACTION_START
        intent.putExtra(XrayVpnService.EXTRA_CONFIG, config)
        startForegroundService(intent)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == VPN_REQUEST_CODE) {
            val result = pendingResult
            val config = pendingConfig
            pendingResult = null
            pendingConfig = null

            if (resultCode == Activity.RESULT_OK && config != null) {
                launchVpnService(config)
                result?.success("Service started")
            } else {
                result?.error("VPN_DENIED", "User denied VPN permission", null)
            }
        }
    }
}
