package com.example.flutter_base_project

import FirstWidgetFactory
import SecondWidgetFactory
import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.widget.Button
import android.widget.Toast
import androidx.core.app.NotificationCompat
import androidx.core.content.getSystemService
import androidx.core.graphics.drawable.IconCompat
import androidx.core.net.toUri
import com.example.flutter_base_project.data.Chat
import com.example.flutter_base_project.data.Contact
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


//abstract class MainActivity internal  constructor(
//    private val notificationHelper: NotificationHelper.
//    private val executor: Executor
//): FlutterFragmentActivity() {
class MainActivity : FlutterActivity() {
    //    private val notificationHelper: NotificationHelper
//        get() {
//            TODO()
//        }
    private val CHANNEL = "com.example.flutter_base_project/show";
    private val CHANNEL2 = "samples.flutter.dev/battery"
    private lateinit var channel: MethodChannel
    private lateinit var channel2: MethodChannel
    private lateinit var button: Button
    private  val REQUEST_BUBBLE = 2
//    private val permissionRequest = PermissionRequest(this, Manifest.permission.POST_NOTIFICATIONS)
    private val chats = Contact.CONTACTS.map { contact ->
        contact.id to Chat(contact)
    }.toMap()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL);
        channel2 = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL2);
//        val headerAdapter = HeaderAdapter { permissionRequest.launch() }
        channel.setMethodCallHandler { call, result ->

            val argument = call.arguments as Map<*, *>;
            val message = argument["msg"];
            if (call.method == "showtoast") {

//                setContentView(R.layout.activity_detail_actiivy)
                Toast.makeText(this, message.toString(), Toast.LENGTH_LONG).show();
//                createChatBubble();
                val chat = chats.getValue(1)
//                executor.execute {
//                    notificationHelper.showNotification(chat, true)
//                }
//                sendNotification();
                notification()
            }

        }
        channel2.setMethodCallHandler { call, result ->
            if (call.method.equals("getBatteryLevel")) {
                val batteryLevel: Int = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)

                    setContentView(R.layout.activity_detail_actiivy)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }

        GeneratedPluginRegistrant.registerWith(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "com.example.flutter_app_demo1.FirstWidgetPlugin",
                FirstWidgetFactory()
            )
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "com.example.flutter_app_demo1.SecondWidgetPlugin",
                SecondWidgetFactory()
            )
    }

    private fun notification() {
        val notificationManager: NotificationManager? = getSystemService() as NotificationManager?

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            notificationManager!!.createNotificationChannel(
                NotificationChannel(
                    "INCOMING_CALL",
                    "HELLO", NotificationManager.IMPORTANCE_HIGH
                ).apply {
                    description = "Hello"
                }
            )
        }

        val fullScreenIntent = Intent(applicationContext, hello::class.java)
        val fullScreenPendingIntent =
            PendingIntent.getActivity(this, 0, fullScreenIntent, PendingIntent.FLAG_IMMUTABLE)
        val iconUri = "content://com.example.android.people/icon/1".toUri()
        val icon = IconCompat.createWithAdaptiveBitmapContentUri(iconUri);
        val pendingIntent = PendingIntent.getActivity(
            context,
            REQUEST_BUBBLE,
            // Launch BubbleActivity as the expanded bubble.
            Intent(context, hello::class.java)
                .setAction(Intent.ACTION_VIEW)
                .setData(iconUri),
            flagUpdateCurrent(mutable = true)
        )
        val notificationBuilder = NotificationCompat.Builder(this, "INCOMING_CALL")
            .setBubbleMetadata(
                NotificationCompat.BubbleMetadata.Builder(
                    pendingIntent,
                    icon
                )
                    .setDesiredHeight(480)
                    .setIntent(
                        PendingIntent.getActivity(
                            context,
                            REQUEST_BUBBLE,
                            // Launch BubbleActivity as the expanded bubble.
                            Intent(context, MainActivity::class.java)
                                .setAction(Intent.ACTION_VIEW),
                            PendingIntent.FLAG_UPDATE_CURRENT
                        )
                    )
                    .apply {
                        // When the bubble is explicitly opened by the user, we can show the bubble
                        // automatically in the expanded state. This works only when the app is in
                        // the foreground.
                        //    if (fromUser) {
                        //        setAutoExpandBubble(true)
                        //    }
                        //    if (fromUser || update) {
                        //        setSuppressNotification(true)
                        //    }
                        setSuppressNotification(true)
                    }
                    .build()
            )
            .setSmallIcon(R.drawable.ic_send)
            .setContentTitle("Incomming call from")
            .setContentText("Tounch here")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setCategory(NotificationCompat.CATEGORY_CALL)
            .setShowWhen(true)
            .setAutoCancel(true)


//            .setFullScreenIntent(fullScreenPendingIntent,true)

        val imcoming = notificationBuilder.build()
        notificationManager?.notify(1, imcoming)
    }
    private fun flagUpdateCurrent(mutable: Boolean): Int {
        return if (mutable) {
            if (Build.VERSION.SDK_INT >= 31) {
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
            } else {
                PendingIntent.FLAG_UPDATE_CURRENT
            }
        } else {
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        }
    }
    private fun chathead() {

    }

    private fun sendNotification() {
        val notificationManager =
            getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val notificationChannel: NotificationChannel =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                notificationManager.getNotificationChannel("some_id")
            } else {
                TODO("VERSION.SDK_INT < O")
            }
        val notifyId = 1
        val channelId = "some_channel_id"

        val notification: Notification = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Toast.makeText(this, "213", Toast.LENGTH_LONG).show();
            Notification.Builder(this@MainActivity)
                .setContentTitle("Some Message")
                .setContentText("You've received new messages!")
                .setSmallIcon(R.drawable.ic_send)
                .setChannelId(channelId)
                .build()
        } else {
            TODO("VERSION.SDK_INT < O")
        }

        notificationManager.notify(notifyId, notification)

    }

    //    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        button = findViewById(R.id.add)
//        button.setOnClickListener{
//            val fragment = TextFragment(23)
//            val bundle =Bundle()
//            bundle.putString("string","123")
//            fragment.arguments = bundle
////            supportFragmentManager.begin
//        }
//    }
    private fun getBatteryLevel(): Int {
        var batteryLevel = -1
        batteryLevel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager: BatteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent: Intent? = ContextWrapper(applicationContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            (intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: 0) * 100 /
                    (intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: 0)
        }
        return batteryLevel
    }
//
//    private fun  createChatBubble() {
//        setContentView(R.layout.activity_main)
//        initializeBubblesManager()
//
//        //Setting the onClick listener the Add Bubble button
//        findViewById<View>(R.id.add).setOnClickListener { addNewBubble() }
//
//
//        //Permission to allow the bubble to overlay the window
//        if (Build.VERSION.SDK_INT >= 23) {
//            if (!Settings.canDrawOverlays(this@MainActivity)) {
//                val intent: Intent = Intent(
//                    Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
//                    Uri.parse("package:$packageName")
//                )
//                startActivityForResult(intent, 1234)
//            }
//        } else {
//            val intent = Intent(this@MainActivity, BluetoothClass.Service::class.java)
//            startService(intent)
//        }
//    }
//
//
//
//    //This method is executed to add a new bubble.
//    private fun addNewBubble() {
//        val bubbleView = LayoutInflater.from(this@MainActivity)
//            .inflate(R.layout.bubble_layout, null) as BubbleLayout
//        bubbleView.setOnBubbleRemoveListener { }
//
//        //The Onclick Listener for the bubble has been set below.
//        bubbleView.setOnBubbleClickListener { //Do what you want onClick of bubble.
//            Toast.makeText(
//                applicationContext, "Clicked !",
//                Toast.LENGTH_SHORT
//            ).show()
//        }
//        bubbleView.setShouldStickToWall(true)
//        bubblesManager!!.addBubble(bubbleView, 60, 20)
//    }
//
//    private fun initializeBubblesManager() {
//        bubblesManager = BubblesManager.Builder(this)
//            .setTrashLayout(R.layout.bubble_trash_layout)
//            .setInitializationCallback { addNewBubble() }
//            .build()
//        bubblesManager?.initialize()
//    }
//
//    override fun onDestroy() {
//        super.onDestroy()
//        bubblesManager!!.recycle()
//    }
}
