import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import com.example.flutter_base_project.R
import com.example.flutter_base_project.TextFragment
import io.flutter.plugin.platform.PlatformView

internal class FirstWidget(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val view: View
    private  lateinit var text :TextView
    private  lateinit var button : Button
    override fun getView(): View {
        return view
    }

    init {
//        view = LayoutInflater.from(context).inflate(R.layout.first_widget, null)
        view = LayoutInflater.from(context).inflate(R.layout.bubble_activity, null)
//        button = findViewById(R.id.add)
//        button.setOnClickListener{
//            val fragment = TextFragment(23)
//            val bundle = Bundle()
//            bundle.putString("string","123")
//            fragment.arguments = bundle
////            supportFragmentManager.begin
//        }
    }

//    override fun onFlutterViewAttached(flutterView: View) {
//        super.onFlutterViewAttached(flutterView)
//        button = flutterView.findViewById(R.id.add)
//        button.setOnClickListener {
////            val fragment = TextFragment(23)
////            val bundle = Bundle()
////            bundle.putString("string","123")
////            fragment.arguments = bundle
////            Toast.makeText(this,message,Toast.LENGTH_LONG).show();
////            text = flutterView.findViewById(R.id.frameLayout)
////            text.text = "Hello1"
//        }
//    }
//
    override fun dispose() {
    }
}