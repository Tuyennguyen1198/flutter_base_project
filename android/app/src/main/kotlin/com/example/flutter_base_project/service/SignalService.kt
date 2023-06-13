package com.example.flutter_base_project.service

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.IBinder
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat

class SignalService :Service () {
    override fun  onCreate(){
        if(Build.VERSION.SDK_INT > Build.VERSION_CODES.O){
            startMyOwnForeground()
        }
        else{
            startForeground(1, Notification())
        }
        super.onCreate()
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private  fun  startMyOwnForeground(){
        val NOTIFICATION_CHANNEL_ID = "example.permanence"
        val channelName = "Background Service"
        val chan = NotificationChannel(
            NOTIFICATION_CHANNEL_ID,
            channelName,
            NotificationManager.IMPORTANCE_HIGH
        )
        chan.lightColor = Color.BLUE
        chan.lockscreenVisibility = Notification.VISIBILITY_PRIVATE
        val manager = (getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager)
        manager.createNotificationChannel(chan)
        val notificationBuilder = NotificationCompat.Builder(this,NOTIFICATION_CHANNEL_ID)
        val notification:Notification= notificationBuilder.setOngoing(true)
            .setContentText("App is runnning in background")
            .setPriority(NotificationManager.IMPORTANCE_MIN)
            .setCategory(Notification.CATEGORY_SERVICE)
            .build()

        startForeground(2,notification)
    }
    override fun onBind(intent: Intent?): IBinder? {
        TODO("Not yet implemented")
    }
}