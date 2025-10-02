import Foundation

struct AppConfig: Codable {
    let url: String
    let title: String
    let enablePullToRefresh: Bool
    let enableFileUpload: Bool
    let enableNotifications: Bool
    let userAgent: String?
    let backgroundColor: String?
    let splashDuration: TimeInterval
    
    init(url: String = "https://www.google.com",
         title: String = "Apkku Webview",
         enablePullToRefresh: Bool = true,
         enableFileUpload: Bool = true,
         enableNotifications: Bool = true,
         userAgent: String? = nil,
         backgroundColor: String? = nil,
         splashDuration: TimeInterval = 2.0) {
        self.url = url
        self.title = title
        self.enablePullToRefresh = enablePullToRefresh
        self.enableFileUpload = enableFileUpload
        self.enableNotifications = enableNotifications
        self.userAgent = userAgent
        self.backgroundColor = backgroundColor
        self.splashDuration = splashDuration
    }
}