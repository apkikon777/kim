import Foundation
import Network

class NetworkUtils: ObservableObject {
    @Published var isConnected = false
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
    
    static func isNetworkAvailable() -> Bool {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkCheck")
        var isConnected = false
        
        let semaphore = DispatchSemaphore(value: 0)
        
        monitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
            semaphore.signal()
        }
        
        monitor.start(queue: queue)
        semaphore.wait()
        monitor.cancel()
        
        return isConnected
    }
}