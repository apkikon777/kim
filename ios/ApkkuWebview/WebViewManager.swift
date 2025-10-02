import SwiftUI
import WebKit
import PhotosUI
import MobileCoreServices

struct WebViewManager: UIViewRepresentable {
    let config: AppConfig
    @Binding var isLoading: Bool
    @Binding var progress: Double
    @Binding var canGoBack: Bool
    @Binding var showNoInternet: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        
        // Configure settings
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.bounces = config.enablePullToRefresh
        
        // Set user agent if specified
        if let userAgent = config.userAgent {
            webView.customUserAgent = userAgent
        }
        
        // Add progress observer
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: config.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        let parent: WebViewManager
        
        init(_ parent: WebViewManager) {
            self.parent = parent
        }
        
        // MARK: - KVO
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == #keyPath(WKWebView.estimatedProgress) {
                if let webView = object as? WKWebView {
                    DispatchQueue.main.async {
                        self.parent.progress = webView.estimatedProgress
                        self.parent.isLoading = webView.estimatedProgress < 1.0
                    }
                }
            } else if keyPath == #keyPath(WKWebView.canGoBack) {
                if let webView = object as? WKWebView {
                    DispatchQueue.main.async {
                        self.parent.canGoBack = webView.canGoBack
                    }
                }
            }
        }
        
        // MARK: - Navigation Delegate
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = true
                self.parent.showNoInternet = false
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
                if !NetworkUtils.isNetworkAvailable() {
                    self.parent.showNoInternet = true
                }
            }
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
                if !NetworkUtils.isNetworkAvailable() {
                    self.parent.showNoInternet = true
                }
            }
        }
        
        // MARK: - UI Delegate (File Upload)
        func webView(_ webView: WKWebView, runOpenPanelWith parameters: WKOpenPanelParameters, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping ([URL]?) -> Void) {
            
            guard parent.config.enableFileUpload else {
                completionHandler(nil)
                return
            }
            
            let alertController = UIAlertController(title: "Select Source", message: nil, preferredStyle: .actionSheet)
            
            // Camera option
            alertController.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                self.presentCamera(completionHandler: completionHandler)
            })
            
            // Photo Library option
            alertController.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
                self.presentPhotoLibrary(completionHandler: completionHandler)
            })
            
            // Document Picker option
            alertController.addAction(UIAlertAction(title: "Files", style: .default) { _ in
                self.presentDocumentPicker(completionHandler: completionHandler)
            })
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
                completionHandler(nil)
            })
            
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(alertController, animated: true)
            }
        }
        
        private func presentCamera(completionHandler: @escaping ([URL]?) -> Void) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = CameraDelegate(completionHandler: completionHandler)
            
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(imagePicker, animated: true)
            }
        }
        
        private func presentPhotoLibrary(completionHandler: @escaping ([URL]?) -> Void) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = CameraDelegate(completionHandler: completionHandler)
            
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(imagePicker, animated: true)
            }
        }
        
        private func presentDocumentPicker(completionHandler: @escaping ([URL]?) -> Void) {
            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.item])
            documentPicker.delegate = DocumentPickerDelegate(completionHandler: completionHandler)
            documentPicker.allowsMultipleSelection = true
            
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(documentPicker, animated: true)
            }
        }
    }
}

// MARK: - Camera Delegate
class CameraDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let completionHandler: ([URL]?) -> Void
    
    init(completionHandler: @escaping ([URL]?) -> Void) {
        self.completionHandler = completionHandler
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.originalImage] as? UIImage,
           let imageData = image.jpegData(compressionQuality: 0.8) {
            
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("image_\(Date().timeIntervalSince1970).jpg")
            
            do {
                try imageData.write(to: tempURL)
                completionHandler([tempURL])
            } catch {
                completionHandler(nil)
            }
        } else {
            completionHandler(nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        completionHandler(nil)
    }
}

// MARK: - Document Picker Delegate
class DocumentPickerDelegate: NSObject, UIDocumentPickerDelegate {
    let completionHandler: ([URL]?) -> Void
    
    init(completionHandler: @escaping ([URL]?) -> Void) {
        self.completionHandler = completionHandler
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        controller.dismiss(animated: true)
        completionHandler(urls)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
        completionHandler(nil)
    }
}