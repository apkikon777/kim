import SwiftUI
import WebKit

struct ContentView: View {
    @StateObject private var configManager = ConfigManager()
    @StateObject private var networkUtils = NetworkUtils()
    
    @State private var isLoading = false
    @State private var progress: Double = 0
    @State private var canGoBack = false
    @State private var showNoInternet = false
    @State private var showSplash = true
    @State private var webView: WKWebView?
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + configManager.config.splashDuration) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showSplash = false
                            }
                        }
                    }
            } else {
                mainContent
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            configManager.loadConfig()
        }
    }
    
    private var mainContent: some View {
        VStack(spacing: 0) {
            // Progress Bar
            if isLoading {
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .frame(height: 4)
                    .animation(.easeInOut, value: progress)
            }
            
            // Main Content
            ZStack {
                if showNoInternet {
                    noInternetView
                } else {
                    webViewContent
                }
            }
        }
        .navigationTitle(configManager.config.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if canGoBack {
                    Button("Back") {
                        webView?.goBack()
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Refresh") {
                    refreshWebView()
                }
            }
        }
    }
    
    private var webViewContent: some View {
        RefreshableScrollView(
            onRefresh: {
                refreshWebView()
            },
            isEnabled: configManager.config.enablePullToRefresh
        ) {
            WebViewManager(
                config: configManager.config,
                isLoading: $isLoading,
                progress: $progress,
                canGoBack: $canGoBack,
                showNoInternet: $showNoInternet
            )
            .onAppear { webView in
                self.webView = webView
            }
        }
    }
    
    private var noInternetView: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Tidak ada koneksi internet")
                .font(.title2)
                .foregroundColor(.primary)
            
            Button("Coba Lagi") {
                refreshWebView()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    private func refreshWebView() {
        if networkUtils.isConnected {
            showNoInternet = false
            webView?.reload()
        } else {
            showNoInternet = true
        }
    }
}

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack {
                Image(systemName: "globe")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                
                Text("Apkku Webview")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
            }
        }
    }
}

struct RefreshableScrollView<Content: View>: View {
    let onRefresh: () -> Void
    let isEnabled: Bool
    let content: Content
    
    init(onRefresh: @escaping () -> Void, isEnabled: Bool = true, @ViewBuilder content: () -> Content) {
        self.onRefresh = onRefresh
        self.isEnabled = isEnabled
        self.content = content()
    }
    
    var body: some View {
        if isEnabled {
            ScrollView {
                content
            }
            .refreshable {
                onRefresh()
            }
        } else {
            content
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}