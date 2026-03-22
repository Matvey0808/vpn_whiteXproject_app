package app.whitexproject.vpn

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Intent
import android.net.VpnService
import android.os.Build
import android.os.ParcelFileDescriptor
import android.util.Log
import androidx.core.app.NotificationCompat
import xraymobile.Xraymobile as Xray

class XrayVpnService : VpnService() {

    companion object {
        const val TAG = "XrayVpnService"
        const val ACTION_START = "app.whitexproject.vpn.START"
        const val ACTION_STOP = "app.whitexproject.vpn.STOP"
        const val EXTRA_CONFIG = "config"
        const val NOTIFICATION_CHANNEL_ID = "channel_vpn"
        const val NOTIFICATION_ID = 1
        const val SOCKS_PORT = 10808
    }

    private var tunInterface: ParcelFileDescriptor? = null

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_STOP -> {
                stopVpn()
                return START_NOT_STICKY
            }
            else -> {
                val config = intent?.getStringExtra(EXTRA_CONFIG) ?: return START_NOT_STICKY
                startVpn(config)
                return START_STICKY
            }
        }
    }

    private fun startVpn(configJson: String) {
        try {
            Xray.startXray(configJson)
            Log.i(TAG, "Xray started, version: ${Xray.getVersion()}")

            tunInterface = Builder()
                .setSession("WhiteX VPN")
                .addAddress("10.0.0.2", 32)
                .addRoute("0.0.0.0", 0)
                .addDnsServer("1.1.1.1")
                .addDnsServer("8.8.8.8")
                .setMtu(1500)
                .establish()

            Log.i(TAG, "TUN interface established")

            val notification = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
                .setContentTitle("WhiteX VPN")
                .setContentText("Connected")
                .setSmallIcon(android.R.drawable.ic_lock_lock)
                .setOngoing(true)
                .build()

            startForeground(NOTIFICATION_ID, notification)
        } catch (e: Exception) {
            Log.e(TAG, "Failed to start VPN: ${e.message}", e)
            stopSelf()
        }
    }

    private fun stopVpn() {
        try {
            Xray.stopXray()
            Log.i(TAG, "Xray stopped")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to stop Xray: ${e.message}", e)
        }

        tunInterface?.close()
        tunInterface = null

        stopForeground(STOP_FOREGROUND_REMOVE)
        stopSelf()
    }

    override fun onRevoke() {
        Log.i(TAG, "VPN revoked by system")
        stopVpn()
    }

    override fun onDestroy() {
        stopVpn()
        super.onDestroy()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                NOTIFICATION_CHANNEL_ID,
                "VPN Service",
                NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }
}
