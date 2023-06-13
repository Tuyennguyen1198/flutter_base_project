package com.example.flutter_base_project

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import org.w3c.dom.Text

class TextFragment(contentLayoutId: Int) : Fragment(contentLayoutId) {
    private  lateinit var text :TextView
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
//        return super.onCreateView(inflater, container, savedInstanceState)
        val view = inflater.inflate(R.layout.bubble_activity,container,false)
//        text = view.findViewById(R.id.editTextTextPersonName)
//        val data = arguments
        text.text = "Hello2"
        return  view
    }
}