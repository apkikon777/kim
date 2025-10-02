package com.apkku.webview

import android.os.Bundle
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.appcompat.app.AppCompatActivity
import org.json.JSONObject
import java.io.IOException
import java.net.HttpURLConnection
import java.net.URL
import kotlinx.coroutines.*

class MainActivity : AppCompatActivity() {
    
    // URL untuk mengunduh config dari server
    // Ganti dengan URL Vercel Anda, contoh: https://apkku.vercel.app/config.json
    private val remoteConfigUrl = "https://apkku.vercel.app/config.json"
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Create WebView programmatically
        val webView = WebView(this)
        
        // Basic WebView settings
        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        
        // Set WebViewClient
        webView.webViewClient = WebViewClient()
        
        // Load URL from config (async)
        loadUrlFromRemoteConfig { url ->
            runOnUiThread {
                webView.loadUrl(url)
            }
        }
        
        // Set as content view
        setContentView(webView)
    }
    
    private fun loadUrlFromRemoteConfig(callback: (String) -> Unit) {
        // Try to load from remote server first
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val remoteUrl = downloadRemoteConfig()
                if (remoteUrl.isNotEmpty()) {
                    callback(remoteUrl)
                    return@launch
                }
            } catch (e: Exception) {
                // If remote fails, fall back to local config
            }
            
            // Fallback to local config
            val localUrl = loadUrlFromLocalConfig()
            callback(localUrl)
        }
    }
    
    private fun downloadRemoteConfig(): String {
        return try {
            val url = URL(remoteConfigUrl)
            val connection = url.openConnection() as HttpURLConnection
            connection.requestMethod = "GET"
            connection.connectTimeout = 5000 // 5 seconds timeout
            connection.readTimeout = 5000
            
            if (connection.responseCode == HttpURLConnection.HTTP_OK) {
                val response = connection.inputStream.bufferedReader().use { it.readText() }
                val jsonObject = JSONObject(response)
                jsonObject.getString("url")
            } else {
                ""
            }
        } catch (e: Exception) {
            ""
        }
    }
    
    private fun loadUrlFromLocalConfig(): String {
        return try {
            val configJson = assets.open("config.json").bufferedReader().use { it.readText() }
            val jsonObject = JSONObject(configJson)
            jsonObject.getString("url")
        } catch (e: IOException) {
            // Final fallback URL
            "https://www.google.com"
        } catch (e: Exception) {
            // Final fallback URL
            "https://www.google.com"
        }
    }
}